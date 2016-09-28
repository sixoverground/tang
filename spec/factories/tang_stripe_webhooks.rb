FactoryGirl.define do
  factory :tang_stripe_webhook, class: 'Tang::StripeWebhook' do
    stripe_id "MyString"
  end
end
