module Tang
  class StripeMailer < ApplicationMailer
    default from: 'team@tangapp.herokuapp.com'

    def admin_dispute_created(dispute)
      @charge = Charge.find_by(stripe_id: dispute.charge)
      if @charge
        mail(to: Tang.admin_email, subject: "Dispute created on charge #{@charge.stripe_id}").deliver
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
      mail(to: @charge.receipt_email, subject: "Thank you!")
    end

    def failed_invoice(charge)
      @charge = charge
      mail(to: @charge.receipt_email, subject: "Oops! Your payment could not be processed.")
    end

  end
end
