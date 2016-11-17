class CreateTangInvoiceItems < ActiveRecord::Migration
  def change
    create_table :tang_invoice_items do |t|
      t.string :stripe_id
      t.integer :amount
      t.string :currency
      t.integer :invoice_id, index: true, foreign_key: true
      t.timestamp :period_start
      t.timestamp :period_end
      t.integer :plan_id, index: true, foreign_key: true
      t.boolean :proration, null: false, default: false
      t.integer :quantity
      t.integer :subscription_id, index: true, foreign_key: true
      t.string :description

      t.timestamps null: false
    end
  end
end
