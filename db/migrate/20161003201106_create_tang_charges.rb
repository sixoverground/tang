class CreateTangCharges < ActiveRecord::Migration
  def change
    create_table :tang_charges do |t|
      t.string :stripe_id
      t.integer :amount
      t.string :currency
      t.string :description
      t.string :receipt_email
      t.string :statement_descriptor
      t.integer :invoice_id, index: true, foreign_key: true

      t.string :card_stripe_id
      t.string :card_address_line1
      t.string :card_address_line1_check
      t.string :card_address_line2
      t.string :card_address_city
      t.string :card_address_country
      t.string :card_address_state
      t.string :card_address_zip
      t.string :card_address_zip_check
      t.string :card_name
      t.string :card_brand
      t.string :card_last4
      t.string :card_dynamic_last4
      t.integer :card_exp_month
      t.integer :card_exp_year
      t.string :card_cvc_check
      t.string :card_country
      t.string :card_tokenization_method
      t.string :card_funding
      t.string :card_fingerprint

      t.timestamps null: false
    end
  end
end
