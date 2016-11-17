Given(/^a coupon exists$/) do
  @stripe_coupon ||= StripeMock.create_test_helper.create_coupon(
    percent_off: 50,
    duration: 'once'
  )
  @coupon ||= FactoryGirl.create(:coupon, stripe_id: @stripe_coupon.id)
end

When(/^I enter a coupon code$/) do
  visit tang.account_subscription_path
  fill_in 'Coupon', with: @coupon.stripe_id
  click_on 'Apply discount'
end

Then(/^I should see a reduced charge amount$/) do
  expect(page).to have_content "You're currently paying $10.00/month on the Amazing Gold Plan."
end