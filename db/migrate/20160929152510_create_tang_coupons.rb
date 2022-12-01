class CreateTangCoupons < ActiveRecord::Migration[4.2]
  def change
    create_table :tang_coupons do |t|
      t.string :stripe_id
      t.string :duration
      t.integer :amount_off
      t.string :currency
      t.integer :duration_in_months
      t.integer :max_redemptions
      t.integer :percent_off
      t.timestamp :redeem_by
      t.integer :redemptions

      t.timestamps null: false
    end
  end
end
