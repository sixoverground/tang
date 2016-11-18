module Tang
  class StripeWebhook < ActiveRecord::Base
    validates :stripe_id, presence: true, uniqueness: true
  end
end
