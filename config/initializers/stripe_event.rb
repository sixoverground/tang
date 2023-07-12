StripeEvent.event_filter = lambda do |params|
  return nil if Tang::StripeWebhook.exists?(stripe_id: params[:id])

  Tang::StripeWebhook.create!(stripe_id: params[:id])
  Stripe::Event.retrieve(params[:id])
end

StripeEvent.configure do |events|
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

  # events.subscribe 'charge.dispute.updated' do |event|
  #   dispute = event.data.object
  # end

  # events.subscribe 'charge.dispute.closed' do |event|
  #   dispute = event.data.object
  # end

  # Subscription lifecycle

  events.subscribe 'invoice.created' do |event|
    Tang::CreateInvoice.call(event)
  end

  events.subscribe('invoice.payment_succeeded') do |event|
    invoice = event.data.object
    charge = Tang::PayInvoice.call(invoice)
    if charge.present?
      if Tang.delayed_email && charge.customer.customer_payment_success_emails_enabled
        Tang::StripeMailer.customer_payment_succeeded(charge).deliver_later
        elsif !Tang.delayed_email && charge.customer.customer_payment_success_emails_enabled
        Tang::StripeMailer.customer_payment_succeeded(charge).deliver_now
      end
      
      if Tang.delayed_email
        Tang::StripeMailer.admin_payment_succeeded(charge).deliver_later if Tang.admin_payment_succeeded_enabled
        else
          Tang::StripeMailer.admin_payment_succeeded(charge).deliver_now if Tang.admin_payment_succeeded_enabled
      end
      # if Tang.delayed_email
      #   Tang::StripeMailer.customer_payment_succeeded(charge).deliver_later
      #   Tang::StripeMailer.admin_payment_succeeded(charge).deliver_later if Tang.admin_payment_succeeded_enabled
      # else
      #   Tang::StripeMailer.customer_payment_succeeded(charge).deliver_now
      #   Tang::StripeMailer.admin_payment_succeeded(charge).deliver_now if Tang.admin_payment_succeeded_enabled
      # end
    end
  end

  # Subscription lifecycle errors

  events.subscribe('invoice.payment_failed') do |event|
    invoice = event.data.object
    charge = Tang::FailInvoice.call(invoice)
    if charge.present?
      # if Tang.delayed_email
      #   Tang::StripeMailer.customer_payment_failed(charge).deliver_later
      #   Tang::StripeMailer.admin_payment_failed(charge).deliver_later if Tang.admin_payment_failed_enabled
      # else
      #   Tang::StripeMailer.customer_payment_failed(charge).deliver_now
      #   Tang::StripeMailer.admin_payment_failed(charge).deliver_now if Tang.admin_payment_failed_enabled
      # end
      if Tang.delayed_email && charge.customer.customer_payment_failed_emails_enabled 
        Tang::StripeMailer.customer_payment_failed(charge).deliver_later
        elsif !Tang.delayed_email && charge.customer.customer_payment_failed_emails_enabled
        Tang::StripeMailer.customer_payment_failed(charge).deliver_now
      end
        if Tang.delayed_email
          Tang::StripeMailer.admin_payment_failed(charge).deliver_later if Tang.admin_payment_failed_enabled
          else
          Tang::StripeMailer.admin_payment_failed(charge).deliver_now if Tang.admin_payment_failed_enabled
        end
    end
  end

  # events.subscribe('customer.subscription.updated') do |event|
  # end

  events.subscribe('customer.subscription.deleted') do |event|
    stripe_subscription = event.data.object
    subscription = Tang::Subscription.find_by(stripe_id: stripe_subscription.id)
    subscription.cancel! if subscription.present? && !subscription.canceled?
  end
end
