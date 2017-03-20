module Tang
  # Preview all emails at http://localhost:3000/rails/mailers/stripe_mailer
  class StripeMailerPreview < ActionMailer::Preview
    def admin_dispute_created
      StripeMailer.admin_dispute_created(Charge.first)
    end

    def admin_payment_succeeded
      StripeMailer.admin_payment_succeeded(Charge.first)
    end

    def admin_payment_failed
      StripeMailer.admin_payment_failed(Charge.first)
    end

    def customer_payment_succeeded
      StripeMailer.customer_payment_succeeded(Charge.first)
    end

    def customer_payment_failed
      StripeMailer.customer_payment_failed(Charge.first)
    end
  end
end
