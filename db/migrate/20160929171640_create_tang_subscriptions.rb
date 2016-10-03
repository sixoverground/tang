class CreateTangSubscriptions < ActiveRecord::Migration
  def change
    create_table :tang_subscriptions do |t|
      t.string :stripe_id
      t.integer :customer_id, index: true
      t.integer :plan_id, index: true, foreign_key: true

      t.decimal :application_fee_percent
      t.integer :quantity
      t.decimal :tax_percent
      t.timestamp :trial_end

      t.timestamps null: false
    end
  end
end
