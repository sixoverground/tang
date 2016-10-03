Before('@javascript') do |scenario|
  StripeMock.start
end

After('@javascript') do |scenario|
  StripeMock.stop
end

Given(/^I am on the account subscription page$/) do
  visit '/tang/account/subscription'
end

Given(/^there is a plan available$/) do
  @stripe_plan ||= StripeMock.create_test_helper.create_plan
  @plan ||= FactoryGirl.create(:plan, stripe_id: @stripe_plan.id)
end

When(/^I select a plan$/) do
  first(:link, 'Upgrade').click
end

When(/^I fill in the payment form with:$/) do |table|
  table.rows_hash.each do |field, value|
    puts "filling in #{field} with #{value}"
    value.split('').each { |c| find_field(field).native.send_keys(c) }
  end
end

When(/^I click the submit payment button$/) do
  number = find_field('Card number').value

  if number == '4000 0000 0000 0002'
    StripeMock.prepare_card_error(:card_declined, :new_customer)
  end

  token = StripeMock.create_test_helper.generate_card_token(number: number)
  page.execute_script "window.testStripeToken = '#{token}';"

  click_on "Submit Payment"
end

Then(/^I should see a subscription success message$/) do
  sleep 5
  expect(page).to have_content "Subscription was successfully created."
end

Then(/^I should see a subscription error message$/) do
  expect(page).to have_content "1 error prohibited this subscription from being saved:"
end

Then(/^I should see my current plan$/) do
  expect(page).to have_content "You're currently paying $20.00/month on the Amazing Gold Plan."
end

Then(/^the payment form should be blank$/) do
  expect(find_field('Card number').value).to be_empty
  expect(find_field('Expiration (MM/YY)').value).to be_empty
  expect(find_field('CVC').value).to be_empty
  expect(find_field('Zip code').value).to be_empty
end