Given(/^I am on the new plan page$/) do
  visit '/tang/admin/plans/new'
end

When(/^I fill in the plan form with:$/) do |table|
  table.rows_hash.each do |field, value|
    if ['Currency', 'Interval'].include? field
      select value, from: field
    else
      fill_in field, with: value
    end
  end
end

When(/^I click the create plan button$/) do
  click_on "Create Plan"
end

Then(/^I should see a plan success message$/) do
  expect(page).to have_content "Plan was successfully created."
end

Then(/^I should see the following plan:$/) do |table|
  table.rows_hash.each do |field, value|
    expect(page).to have_content value
  end
end

Then(/^I should see a plan error message$/) do
  expect(page).to have_content "1 error prohibited this plan from being saved:"
end

Then(/^I should see the following plan form field values:$/) do |table|
  table.rows_hash.each do |field, value|
    expect(find_field(field).value).to eq(value)
  end
end