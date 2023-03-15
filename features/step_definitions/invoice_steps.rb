Given(/^an invoice exists$/) do
  @invoice ||= FactoryBot.create(:invoice, customer: @customer, subscription: @subscription)
end

When(/^I view my receipts$/) do
  visit tang.account_receipts_path
end

Then(/^I should see a list of receipts with download buttons$/) do
  expect(page).to have_content 'Download PDF'
end
