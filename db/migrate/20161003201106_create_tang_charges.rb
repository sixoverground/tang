class CreateTangCharges < ActiveRecord::Migration
  def change
    create_table :tang_charges do |t|
      t.string :stripe_id
      t.integer :amount
      t.string :currency
      t.string :description
      t.string :receipt_email
      # t.integer :customer_id, index: true
      t.string :statement_descriptor
      t.integer :invoice_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
