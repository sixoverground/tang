class CreateTangPlans < ActiveRecord::Migration
  def change
    create_table :tang_plans do |t|
      t.string :stripe_id
      t.integer :amount
      t.string :currency
      t.string :interval
      t.integer :interval_count
      t.string :name
      t.string :statement_descriptor
      t.integer :trial_period_days
      t.integer :order
      t.boolean :highlight, null: false, default: false
      t.text :features
      t.text :description

      t.timestamps null: false
    end
  end
end
