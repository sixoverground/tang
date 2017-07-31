class AddSubscriptionIndexes < ActiveRecord::Migration
  def change
    add_index :tang_subscriptions, [:customer_id, :created_at], where: "status != 'canceled'", name: 'index_tang_subscriptions_on_customer_and_created_at_and_status'
  end
end
