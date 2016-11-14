Given(/^there is a plan available$/) do
  @stripe_plan ||= StripeMock.create_test_helper.create_plan
  @plan ||= FactoryGirl.create(:plan, stripe_id: @stripe_plan.id)
end

Given(/^there is a trial plan available$/) do
  Tang::Plan.destroy_all
  @stripe_plan ||= StripeMock.create_test_helper.create_plan(trial_period_days: 30)
  @plan ||= FactoryGirl.create(:plan, stripe_id: @stripe_plan.id, trial_period_days: 30)
end

Given(/^there are (\d+) plans available$/) do |arg1|
  Tang::Plan.destroy_all
  @stripe_plan ||= StripeMock.create_test_helper.create_plan(id: 'gold')
  @plan ||= FactoryGirl.create(:plan, stripe_id: @stripe_plan.id, order: 1)
  @stripe_premium_plan ||= StripeMock.create_test_helper.create_plan(id: 'diamond')
  @premium_plan ||= FactoryGirl.create(:premium_plan, stripe_id: @stripe_premium_plan.id, order: 2)
end

Given(/^I am subscribed to a plan$/) do
  # token = StripeMock.create_test_helper.generate_card_token

  token = StripeMock.create_test_helper.generate_card_token(address_zip: '90210')
  # Tang::SaveCard.call(@customer, token)
  @subscription = Tang::CreateSubscription.call(@plan, @customer, token)

  # @subscription ||= FactoryGirl.create(:subscription, plan: @plan, customer: @customer)
  puts "SUB: #{@subscription.id}"
  # @customer.reload
end

When(/^I select the plan from the subscription page$/) do
  visit tang.account_subscription_path
  first(:link, 'Upgrade').click
end

When(/^I complete the payment form with:$/) do |table|
  table.rows_hash.each do |field, value|
    fill_in field, with: value
  end

  name = find_field('Cardholder name').value
  number = find_field('Card number').value
  exp = find_field('Expiration (MM/YY)').value
  cvc = find_field('CVC').value
  address_zip = find_field('Zip code').value

  if number == '4000 0000 0000 0002'
    StripeMock.prepare_card_error(:card_declined, :new_customer)
  end

  token = StripeMock.create_test_helper.generate_card_token(
    name: name, 
    number: number,
    exp: exp,
    cvc: cvc,
    address_zip: address_zip
  )

  page.execute_script "window.testStripeToken = '#{token}';"

  click_on "Submit Payment"
  sleep 4
end

When(/^I upgrade to a new plan$/) do
  visit tang.account_subscription_path
  first(:link, 'Upgrade').click
end

Then(/^I should see a subscription created success message$/) do
  expect(page).to have_content "Subscription was successfully created."
end

Then(/^I should see my current subscription$/) do
  expect(page).to have_content "You're currently paying $20.00/month on the Amazing Gold Plan."
end

Then(/^I should be an active customer$/) do
  @customer.reload
  period_end = @customer.subscription.created_at.change(usec: 0) + 30.days
  expect(@customer.active_until).to eq(period_end)
end

Then(/^I should receive a free trial period$/) do
  @customer.reload
  @customer.subscription.reload
  trial_end = @customer.subscription.created_at.change(usec: 0) + 30.days
  expect(@customer.subscription.trial_end).to eq(trial_end)
end




