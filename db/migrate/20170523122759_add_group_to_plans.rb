class AddGroupToPlans < ActiveRecord::Migration[4.2]
  def change
    add_column :tang_plans, :group, :integer
  end
end
