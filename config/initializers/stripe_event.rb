StripeEvent.event_retriever = lambda do |params|
  # return nil if Rails.env.production? && !params[:livemode]
  return nil if Tang::StripeWebhook.exists?(stripe_id: params[:id])
  Tang::StripeWebhook.create!(stripe_id: params[:id])
  Stripe::Event.retrieve(params[:id])
end

StripeEvent.configure do |events|
  events.all do |event|
    logger.debug "stripe_event: #{event}"
  end

  # Disputes

  events.subscribe 'charge.dispute.created' do |event|
    dispute = event.data.object
    # TODO: create actual dispute model
    StripeMailer.admin_dispute_created(dispute).deliver
  end

  events.subscribe 'charge.dispute.updated' do |event|
    dispute = event.data.object
  end

  events.subscribe 'charge.dispute.closed' do |event|
    dispute = event.data.object
  end

  # Subscription lifecycle

  events.subscribe 'invoice.created' do |event|
    invoice = CreateInvoice.call(event)
  end

  # events.subscribe 'charge.succeeded' do |event|
  #   charge = event.data.object
  #   StripeMailer.receipt(charge).deliver
  #   StripeMailer.admin_charge_succeeded(charge).deliver
  # end

  events.subscribe('invoice.payment_succeeded') do |event|
    invoice = event.data.object
    charge = PayInvoice.call(invoice)
    StripeMailer.receipt(charge).deliver
    StripeMailer.admin_charge_succeeded(charge).deliver
  end

  # Subscription lifecycle errors

  events.subscribe('invoice.payment_failed') do |event|
    invoice = event.data.object
    charge = FailInvoice.call(invoice)
    StripeMailer.failed_invoice(charge).deliver
    StripeMailer.admin_charge_failed(charge).deliver
  end

  # events.subscribe('customer.subscription.updated') do |event|
  # end

  events.subscribe('customer.subscription.deleted') do |event|
    stripe_subscription = event.data.object
    subscription = Subscription.find_by(stripe_id: stripe_subscription.id)
    subscription.cancel!
  end
end