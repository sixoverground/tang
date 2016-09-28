module Tang
  class StripeWebhook < ActiveRecord::Base
    validates :stripe_id, uniqueness: true
  end
end
