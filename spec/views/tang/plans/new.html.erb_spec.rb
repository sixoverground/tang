require 'rails_helper'

RSpec.describe "tang/plans/new", type: :view do
  before(:each) do
    assign(:plan, Tang::Plan.new(
      :stripe_id => "MyString",
      :amount => 1,
      :currency => "MyString",
      :interval => "MyString",
      :interval_count => 1,
      :name => "MyString",
      :statement_descriptor => "MyString",
      :trial_period_days => 1
    ))
  end

  it "renders new plan form" do
    render

    assert_select "form[action=?][method=?]", tang.plans_path, "post" do

      assert_select "input#plan_stripe_id[name=?]", "plan[stripe_id]"

      assert_select "input#plan_amount[name=?]", "plan[amount]"

      assert_select "input#plan_currency[name=?]", "plan[currency]"

      assert_select "input#plan_interval[name=?]", "plan[interval]"

      assert_select "input#plan_interval_count[name=?]", "plan[interval_count]"

      assert_select "input#plan_name[name=?]", "plan[name]"

      assert_select "input#plan_statement_descriptor[name=?]", "plan[statement_descriptor]"

      assert_select "input#plan_trial_period_days[name=?]", "plan[trial_period_days]"
    end
  end
end
