class AddStatusToTangSubscriptions < ActiveRecord::Migration
  def change
    add_column :tang_subscriptions, :status, :string
  end
end
