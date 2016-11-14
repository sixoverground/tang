class AddCouponToCustomersAndSubscriptions < ActiveRecord::Migration
  def change
    add_column :users, :coupon_id, :integer, index: true, foreign_key: true
    add_column :tang_subscriptions, :coupon_id, :integer, index: true, foreign_key: true
  end
end
