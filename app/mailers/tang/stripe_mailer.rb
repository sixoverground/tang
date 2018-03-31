module Tang
  class StripeMailer < ApplicationMailer
    add_template_helper(Tang::ApplicationHelper)
    default from: Tang.admin_email

    def admin_dispute_created(charge)
      @charge = charge
      mail(to: Tang.admin_email, subject: "Dispute created on charge #{@charge.stripe_id}")
    end

    def admin_payment_succeeded(charge)
      @charge = charge
      mail(to: Tang.admin_email, subject: "Woo! Charge succeeded!")
    end

    def admin_payment_failed(charge)
      @charge = charge
      mail(to: Tang.admin_email, subject: "Oh no! Charge failed!")
    end

    def customer_payment_succeeded(charge)
      @receipt = charge
      if @receipt.customer.present?
        mail(to: @receipt.customer.email, subject: "Thank you!")
      end
    end

    def customer_payment_failed(charge)
      @charge = charge
      if @charge.customer.present?
        mail(to: @charge.customer.email, subject: "Oops! Your payment could not be processed.")
      end
    end

  end
end
