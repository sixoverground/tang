class AddGroupToPlans < ActiveRecord::Migration
  def change
    add_column :tang_plans, :group, :integer
  end
end
