class CreateTangCards < ActiveRecord::Migration
  def change
    create_table :tang_cards do |t|
      t.integer :customer_id, index: true

      t.string :stripe_id
      t.string :address_line1
      t.string :address_line1_check
      t.string :address_line2
      t.string :address_city
      t.string :address_country
      t.string :address_state
      t.string :address_zip
      t.string :address_zip_check

      t.string :name
      t.string :brand
      t.string :last4
      t.string :dynamic_last4
      t.integer :exp_month
      t.integer :exp_year
      t.string :cvc_check
      t.string :country
      t.string :tokenization_method
      t.string :funding
      t.string :fingerprint

      t.timestamps null: false
    end
  end
end
