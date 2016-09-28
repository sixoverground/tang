FactoryGirl.define do
  factory :tang_plan, class: 'Tang::Plan' do
    stripe_id "MyString"
    amount 1
    currency "MyString"
    interval "MyString"
    interval_count 1
    name "MyString"
    statement_descriptor "MyString"
    trial_period_days 1
  end
end
