module Tang
  class StripeMailer < ApplicationMailer
    default from: 'team@tangapp.herokuapp.com'

    def admin_dispute_created(dispute)
      @charge = Charge.find_by(stripe_id: dispute.charge)
      if @charge.present?
        mail(to: Tang.admin_email, subject: "Dispute created on charge #{@charge.stripe_id}")
      end
    end

    def admin_charge_succeeded(charge)
      @charge = charge
      mail(to: Tang.admin_email, subject: "Woo! Charge succeeded!")
    end

    def admin_charge_failed(charge)
      @charge = charge
      mail(to: Tang.admin_email, subject: "Oh no! Charge failed!")
    end

    def receipt(charge)
      @charge = charge
      mail(to: @charge.customer.email, subject: "Thank you!")
    end

    def failed_invoice(charge)
      @charge = charge
      mail(to: @charge.customer.email, subject: "Oops! Your payment could not be processed.")
    end

  end
end
