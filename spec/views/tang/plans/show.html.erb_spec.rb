require 'rails_helper'

RSpec.describe "plans/show", type: :view do
  before(:each) do
    @plan = assign(:plan, Plan.create!(
      :stripe_id => "Stripe",
      :amount => 2,
      :currency => "Currency",
      :interval => "Interval",
      :interval_count => 3,
      :name => "Name",
      :statement_descriptor => "Statement Descriptor",
      :trial_period_days => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Stripe/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Currency/)
    expect(rendered).to match(/Interval/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Statement Descriptor/)
    expect(rendered).to match(/4/)
  end
end
