module Tang
  # Preview all emails at http://localhost:3000/rails/mailers/stripe_mailer
  class SubscriptionMailerPreview < ActionMailer::Preview
    def upgraded
      SubscriptionMailer.upgraded(Subscription.first)
    end
  end
end
