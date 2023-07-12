# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_05_30_172604) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tang_cards", id: :serial, force: :cascade do |t|
    t.integer "customer_id"
    t.string "stripe_id"
    t.string "address_line1"
    t.string "address_line1_check"
    t.string "address_line2"
    t.string "address_city"
    t.string "address_country"
    t.string "address_state"
    t.string "address_zip"
    t.string "address_zip_check"
    t.string "name"
    t.string "brand"
    t.string "last4"
    t.string "dynamic_last4"
    t.integer "exp_month"
    t.integer "exp_year"
    t.string "cvc_check"
    t.string "country"
    t.string "tokenization_method"
    t.string "funding"
    t.string "fingerprint"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_tang_cards_on_customer_id"
    t.index ["stripe_id"], name: "index_tang_cards_on_stripe_id", unique: true
  end

  create_table "tang_charges", id: :serial, force: :cascade do |t|
    t.string "stripe_id"
    t.integer "amount"
    t.string "currency"
    t.string "description"
    t.string "receipt_email"
    t.string "statement_descriptor"
    t.integer "invoice_id"
    t.string "card_stripe_id"
    t.string "card_address_line1"
    t.string "card_address_line1_check"
    t.string "card_address_line2"
    t.string "card_address_city"
    t.string "card_address_country"
    t.string "card_address_state"
    t.string "card_address_zip"
    t.string "card_address_zip_check"
    t.string "card_name"
    t.string "card_brand"
    t.string "card_last4"
    t.string "card_dynamic_last4"
    t.integer "card_exp_month"
    t.integer "card_exp_year"
    t.string "card_cvc_check"
    t.string "card_country"
    t.string "card_tokenization_method"
    t.string "card_funding"
    t.string "card_fingerprint"
    t.string "status"
    t.datetime "created"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_tang_charges_on_invoice_id"
    t.index ["stripe_id"], name: "index_tang_charges_on_stripe_id", unique: true
  end

  create_table "tang_coupons", id: :serial, force: :cascade do |t|
    t.string "stripe_id"
    t.string "duration"
    t.integer "amount_off"
    t.string "currency"
    t.integer "duration_in_months"
    t.integer "max_redemptions"
    t.integer "percent_off"
    t.datetime "redeem_by"
    t.integer "redemptions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stripe_id"], name: "index_tang_coupons_on_stripe_id", unique: true
  end

  create_table "tang_invoice_items", id: :serial, force: :cascade do |t|
    t.string "stripe_id"
    t.integer "amount"
    t.string "currency"
    t.integer "invoice_id"
    t.datetime "period_start"
    t.datetime "period_end"
    t.integer "plan_id"
    t.boolean "proration", default: false, null: false
    t.integer "quantity"
    t.integer "subscription_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_tang_invoice_items_on_invoice_id"
    t.index ["plan_id"], name: "index_tang_invoice_items_on_plan_id"
    t.index ["stripe_id"], name: "index_tang_invoice_items_on_stripe_id", unique: true
    t.index ["subscription_id"], name: "index_tang_invoice_items_on_subscription_id"
  end

  create_table "tang_invoices", id: :serial, force: :cascade do |t|
    t.string "stripe_id"
    t.integer "subscription_id"
    t.datetime "period_start"
    t.datetime "period_end"
    t.integer "customer_id"
    t.datetime "date"
    t.string "currency"
    t.integer "subtotal"
    t.integer "coupon_id"
    t.integer "tax_percent"
    t.integer "tax"
    t.integer "total"
    t.integer "amount_due"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invoice_pdf"
    t.index ["coupon_id"], name: "index_tang_invoices_on_coupon_id"
    t.index ["customer_id"], name: "index_tang_invoices_on_customer_id"
    t.index ["stripe_id"], name: "index_tang_invoices_on_stripe_id", unique: true
    t.index ["subscription_id"], name: "index_tang_invoices_on_subscription_id"
  end

  create_table "tang_plans", id: :serial, force: :cascade do |t|
    t.string "stripe_id"
    t.integer "amount"
    t.string "currency"
    t.string "interval"
    t.integer "interval_count"
    t.string "name"
    t.string "statement_descriptor"
    t.integer "trial_period_days"
    t.integer "order"
    t.boolean "highlight", default: false, null: false
    t.text "features"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group"
    t.index ["stripe_id"], name: "index_tang_plans_on_stripe_id", unique: true
  end

  create_table "tang_stripe_webhooks", id: :serial, force: :cascade do |t|
    t.string "stripe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stripe_id"], name: "index_tang_stripe_webhooks_on_stripe_id", unique: true
  end

  create_table "tang_subscriptions", id: :serial, force: :cascade do |t|
    t.string "stripe_id"
    t.integer "customer_id"
    t.integer "plan_id"
    t.decimal "application_fee_percent"
    t.integer "quantity"
    t.decimal "tax_percent"
    t.datetime "trial_end"
    t.integer "coupon_id"
    t.datetime "coupon_start"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coupon_id"], name: "index_tang_subscriptions_on_coupon_id"
    t.index ["customer_id", "created_at"], name: "index_tang_subscriptions_on_customer_and_created_at_and_status", where: "((status)::text <> 'canceled'::text)"
    t.index ["customer_id"], name: "index_tang_subscriptions_on_customer_id"
    t.index ["plan_id"], name: "index_tang_subscriptions_on_plan_id"
    t.index ["stripe_id"], name: "index_tang_subscriptions_on_stripe_id", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_id"
    t.integer "account_balance"
    t.string "business_vat_id"
    t.string "currency"
    t.boolean "delinquent", default: false, null: false
    t.string "description"
    t.datetime "active_until"
    t.integer "coupon_id"
    t.datetime "coupon_start"
    t.integer "subscription_coupon_id"
    t.string "role"
    t.boolean "customer_payment_success_emails_enabled", default: true, null: false
    t.boolean "customer_payment_failed_emails_enabled", default: true, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["stripe_id"], name: "index_users_on_stripe_id", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
