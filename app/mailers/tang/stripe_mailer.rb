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

    def receipt(charge)
      @charge = charge
      mail(to: @charge.receipt_email, subject: "Thank you!")
    end

  end
end
