class CreateTang < ActiveRecord::Migration
  def change
    create_table :tang_stripe_webhooks do |t|
      t.string :stripe_id

      t.timestamps null: false
    end

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

      t.timestamps null: false
    end

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

    add_column Tang.customer_class.to_s.downcase.pluralize, :stripe_id, :string
    add_column Tang.customer_class.to_s.downcase.pluralize, :account_balance, :integer
    add_column Tang.customer_class.to_s.downcase.pluralize, :business_vat_id, :string
    add_column Tang.customer_class.to_s.downcase.pluralize, :currency, :string
    add_column Tang.customer_class.to_s.downcase.pluralize, :delinquent, :boolean, null: false, default: false
    add_column Tang.customer_class.to_s.downcase.pluralize, :description, :string
    add_column Tang.customer_class.to_s.downcase.pluralize, :active_until, :timestamp
    add_column Tang.customer_class.to_s.downcase.pluralize, :coupon_id, :integer, index: true, foreign_key: true
    add_column Tang.customer_class.to_s.downcase.pluralize, :coupon_start, :timestamp
    add_column Tang.customer_class.to_s.downcase.pluralize, :subscription_coupon_id, :integer, index: true, foreign_key: true

    create_table :tang_subscriptions do |t|
      t.string :stripe_id
      t.integer :customer_id, index: true
      t.integer :plan_id, index: true, foreign_key: true

      t.decimal :application_fee_percent
      t.integer :quantity
      t.decimal :tax_percent
      t.timestamp :trial_end

      t.integer :coupon_id, index: true, foreign_key: true
      t.timestamp :coupon_start

      t.string :status
      
      t.timestamps null: false
    end

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

      t.string :status
      t.timestamp :created

      t.timestamps null: false
    end
  end
end