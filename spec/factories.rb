FactoryGirl.define do
  factory :tang_invoice, class: 'Tang::Invoice' do
    stripe_id "MyString"
    application_fee 1
    description "MyString"
    statement_descriptor "MyString"
    subscription nil
    tax_percent "9.99"
    period_start "2016-10-03 23:54:34"
    period_end "2016-10-03 23:54:34"
    customer_id 1
    date "2016-10-03 23:54:34"
    charge nil
    amount_due 1
    subtotal 1
    total 1
    tax 1
    next_payment_attempt "2016-10-03 23:54:34"
    ending_balance 1
    currency "MyString"
  end
  factory :tang_charge, class: 'Tang::Charge' do
    amount 1
    currency "MyString"
    description "MyString"
    receipt_email "MyString"
    customer_id 1
    statement_descriptor "MyString"
  end
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
      role 'admin'
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

  factory :card, class: 'Tang::Card' do
    customer
    name 'John'
    last4 '0002'
    exp_month 12
    exp_year 2017
    address_zip "90210"
  end
end