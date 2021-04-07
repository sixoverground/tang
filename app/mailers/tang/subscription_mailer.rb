module Tang
  class SubscriptionMailer < ApplicationMailer
    helper Tang::ApplicationHelper
    default from: Tang.admin_email

    def upgraded(subscription)
      @subscription = subscription
      mail(to: @subscription.customer.email, subject: "Oh, wow! Excited to have you on our #{@subscription.plan.name} plan!")
    end
  end
end
