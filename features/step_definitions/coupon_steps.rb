# Given

Given(/^a coupon exists$/) do
  @stripe_coupon ||= StripeMock.create_test_helper.create_coupon(
    percent_off: 50,
    duration: 'once'
  )
  @coupon ||= FactoryBot.create(:coupon, stripe_id: @stripe_coupon.id)
end

# When

When(/^I enter a coupon code$/) do
  visit tang.account_subscription_path
  fill_in 'Coupon', with: @coupon.stripe_id
  click_on 'Apply discount'
end

When(/^I create a new coupon with:$/) do |table|
  visit tang.new_admin_coupon_path
  table.rows_hash.each do |field, value|
    if ['Duration'].include? field
      select value, from: field
    else
      fill_in field, with: value
    end
  end
  click_on "Create Coupon"
end

When(/^I remove the coupon$/) do
  visit tang.account_subscription_path
  click_on 'Remove discount'
end

# Then

Then(/^I should see a reduced charge amount$/) do
  expect(@customer.subscription.coupon).to eq(@coupon)
end

Then(/^I should see a coupon created success message$/) do
  expect(page).to have_content "Coupon was successfully created."
end

Then(/^I should see the following coupon:$/) do |table|
  table.rows_hash.each do |field, value|
    expect(page).to have_content value
  end
end

Then(/^I should see the full charge amount$/) do
  expect(page).to have_selector(:link_or_button, "Apply discount")
end