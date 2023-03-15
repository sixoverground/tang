require 'rails_helper'

module Tang
  describe CreatePlan do
    before { StripeMock.start }
    after { StripeMock.stop }

    it 'creates a new plan' do
      plan = FactoryBot.build(:plan)

      stripe_plan = CreatePlan.call(plan)

      expect(stripe_plan.errors).to be_empty
      expect(stripe_plan.name).to eq plan.name
    end
  end
end
