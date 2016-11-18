FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :stripe_webhook, class: 'Tang::StripeWebhook' do
    stripe_id SecureRandom.uuid
  end

  factory :plan, class: 'Tang::Plan' do
    stripe_id SecureRandom.uuid
    name 'Amazing Gold Plan'
    amount 2000
    currency 'usd'
    interval 'month'

    factory :premium_plan do
      name 'Amazing Diamond Plan'
      amount 5000
    end
  end

  factory :coupon, class: 'Tang::Coupon' do
    stripe_id SecureRandom.uuid
    duration 'once'
    percent_off 50
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

  factory :card, class: 'Tang::Card' do
    stripe_id SecureRandom.uuid
    customer
    name 'John'
    last4 '0002'
    exp_month 12
    exp_year 2017
    address_zip "90210"
  end

  factory :subscription, class: 'Tang::Subscription' do
    stripe_id SecureRandom.uuid
    customer
    plan
  end

  factory :invoice, class: 'Tang::Invoice' do
    stripe_id SecureRandom.uuid
    customer
    subscription
    date Time.now
    period_start Time.now
    period_end Time.now + 30.days
    # amount_due 1000
    # subtotal 1000
    # tax 0
    total 1000
    # ending_balance 0
    currency 'usd'
  end

  factory :invoice_item, class: 'Tang::InvoiceItem' do
    stripe_id SecureRandom.uuid
    amount 1
    currency "usd"
    invoice
    period_start "2016-11-14 13:16:51"
    period_end "2016-11-14 13:16:51"
    plan
    proration false
    quantity 1
    subscription
    description "MyString"
  end

  factory :charge, class: 'Tang::Charge' do
    stripe_id SecureRandom.uuid
    invoice
    amount 1000
    currency 'usd'
  end
end