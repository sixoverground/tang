module Tang
  class StripeMailer < ApplicationMailer
    helper Tang::ApplicationHelper
    default from: Tang.admin_email

    def admin_dispute_created(charge)
      @charge = charge
      mail(to: Tang.admin_email, subject: "Dispute created on charge #{@charge.stripe_id}")
    end

    def admin_payment_succeeded(charge)
      @charge = charge
      mail(to: Tang.admin_email, subject: 'Woo! Charge succeeded!')
    end

    def admin_payment_failed(charge)
      @charge = charge
      mail(to: Tang.admin_email, subject: 'Oh no! Charge failed!')
    end

    def customer_payment_succeeded(charge)
      @receipt = charge
      return unless @receipt.customer.present?

      mail(to: @receipt.customer.email, subject: 'Thank you!')
    end

    def customer_payment_failed(charge)
      @charge = charge
      return unless @charge.customer.present?

      mail(to: @charge.customer.email, subject: 'Oops! Your payment could not be processed.')
    end
  end
end
