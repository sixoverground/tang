FactoryGirl.define do
  # ::Kernel.raise 'factories are getting loaded'

  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :customer, class: 'User' do
    email
    password 'password'
    # stripe_id SecureRandom.uuid

    factory :admin do
      # TODO: add admin role
    end
  end

  factory :plan, class: 'Tang::Plan' do
    stripe_id SecureRandom.uuid
    name 'Amazing Gold Plan'
    amount 2000
    currency 'usd'
    interval 'month'
  end

  factory :subscription, class: 'Tang::Subscription' do
    stripe_id SecureRandom.uuid
    customer
    plan
  end

  factory :stripe_webhook, class: 'Tang::StripeWebhook' do
    stripe_id SecureRandom.uuid
  end

end