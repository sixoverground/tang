class CreateTangInvoices < ActiveRecord::Migration
  def change
    create_table :tang_invoices do |t|
      t.string :stripe_id
      t.integer :subscription_id, index: true, foreign_key: true
      t.timestamp :period_start
      t.timestamp :period_end
      t.integer :customer_id, index: true
      t.timestamp :date
      t.string :currency

      t.integer :subtotal
      t.integer :coupon_id, index: true, foreign_key: true
      t.integer :tax_percent
      t.integer :tax
      t.integer :total
      t.integer :amount_due

      t.timestamps null: false
    end
  end
end
