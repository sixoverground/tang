Given(/^a customer is subscribed to a plan$/) do
  stripe_product ||= StripeMock.create_test_helper.create_product
  @stripe_plan ||= StripeMock.create_test_helper.create_plan(product: stripe_product.id)
  @plan ||= FactoryBot.create(:plan, stripe_id: @stripe_plan.id)
  create_customer
  @subscription ||= FactoryBot.create(:subscription, plan: @plan, customer: @customer)
  # steps( %Q(
  #   Given I am logged in as a customer
  #   And there is a plan available
  #   When I select the plan from the subscription page
  #   And I complete the payment form with:
  #     | Cardholder name    | John               |
  #     | Card number        | "4242424242424242" |
  #     | Expiration (MM/YY) | 12/17              |
  #     | CVC                | 123                |
  #     | Zip code           | 90210              |
  # ) )
end

When(/^I create a new plan with:$/) do |table|
  visit tang.new_admin_plan_path
  table.rows_hash.each do |field, value|
    if %w[Currency Interval].include? field
      select value, from: field
    else
      fill_in field, with: value
    end
  end
  click_on 'Create Plan'
end

When(/^I change a subscription to the new plan$/) do
  subscription = Tang::Subscription.last
  visit tang.edit_admin_subscription_path(subscription)
  select 'Amazing New Gold Plan', from: 'Plan'
  click_on 'Update Subscription'
end

Then(/^I should see a plan created success message$/) do
  expect(page).to have_content 'Plan was successfully created.'
end

Then(/^I should see the following plan:$/) do |table|
  table.rows_hash.each do |_field, value|
    expect(page).to have_content value
  end
end

Then(/^I should see a subscription updated success message$/) do
  expect(page).to have_content 'Subscription was successfully updated.'
end

Then(/^I should see the following subscription:$/) do |table|
  table.rows_hash.each do |_field, value|
    expect(page).to have_content value
  end
end
