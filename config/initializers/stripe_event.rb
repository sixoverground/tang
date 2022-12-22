StripeEvent.event_filter = lambda do |params|
  # return nil if Rails.env.production? && !params[:livemode]
  return nil if Tang::StripeWebhook.exists?(stripe_id: params[:id])
  Tang::StripeWebhook.create!(stripe_id: params[:id])
  Stripe::Event.retrieve(params[:id])
end

StripeEvent.configure do |events|
  events.all do |event|
  end

  # Disputes

  events.subscribe 'charge.dispute.created' do |event|
    dispute = event.data.object
    # TODO: create actual dispute model
    charge = Tang::Charge.find_by(stripe_id: dispute.charge)
    if Tang.delayed_email
      Tang::StripeMailer.admin_dispute_created(charge).deliver_later
    else
      Tang::StripeMailer.admin_dispute_created(charge).deliver_now
    end
  end

  events.subscribe 'charge.dispute.updated' do |event|
    dispute = event.data.object
  end

  events.subscribe 'charge.dispute.closed' do |event|
    dispute = event.data.object
  end

  # Subscription lifecycle

  events.subscribe 'invoice.created' do |event|
    invoice = Tang::CreateInvoice.call(event)
  end

  # events.subscribe 'charge.succeeded' do |event|
  #   charge = event.data.object
  #   StripeMailer.receipt(charge).deliver
  #   StripeMailer.admin_charge_succeeded(charge).deliver
  # end

  events.subscribe('invoice.payment_succeeded') do |event|
    puts "invoice.payment_succeeded hit"
    invoice = event.data.object
    charge = Tang::PayInvoice.call(invoice)
    if charge.present?
      puts "admin email deliver now hit"
      if Tang.delayed_email
        Tang::StripeMailer.customer_payment_succeeded(charge).deliver_later
        if Tang.admin_payment_succeeded_enabled
          Tang::StripeMailer.admin_payment_succeeded(charge).deliver_later
        end
      else
        Tang::StripeMailer.customer_payment_succeeded(charge).deliver_now
        if Tang.admin_payment_succeeded_enabled
        Tang::StripeMailer.admin_payment_succeeded(charge).deliver_now
        end
      end
    end
  end

  # Subscription lifecycle errors

  events.subscribe('invoice.payment_failed') do |event|
    invoice = event.data.object
    charge = Tang::FailInvoice.call(invoice)
    if charge.present?
      if Tang.delayed_email
        Tang::StripeMailer.customer_payment_failed(charge).deliver_later
        if Tang.admin_payment_failed_enabled
        Tang::StripeMailer.admin_payment_failed(charge).deliver_later
        end
      else
        Tang::StripeMailer.customer_payment_failed(charge).deliver_now
        if Tang.admin_payment_failed_enabled
        Tang::StripeMailer.admin_payment_failed(charge).deliver_now
        end
      end
    end
  end

  # events.subscribe('customer.subscription.updated') do |event|
  # end

  events.subscribe('customer.subscription.deleted') do |event|
    stripe_subscription = event.data.object
    subscription = Tang::Subscription.find_by(stripe_id: stripe_subscription.id)
    if subscription.present?
      subscription.cancel! if !subscription.canceled?
    end
  end
end