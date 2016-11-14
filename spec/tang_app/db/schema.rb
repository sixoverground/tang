# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161111165754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tang_cards", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "stripe_id"
    t.string   "address_line1"
    t.string   "address_line1_check"
    t.string   "address_line2"
    t.string   "address_city"
    t.string   "address_country"
    t.string   "address_state"
    t.string   "address_zip"
    t.string   "address_zip_check"
    t.string   "name"
    t.string   "brand"
    t.string   "last4"
    t.string   "dynamic_last4"
    t.integer  "exp_month"
    t.integer  "exp_year"
    t.string   "cvc_check"
    t.string   "country"
    t.string   "tokenization_method"
    t.string   "funding"
    t.string   "fingerprint"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "tang_cards", ["customer_id"], name: "index_tang_cards_on_customer_id", using: :btree

  create_table "tang_charges", force: :cascade do |t|
    t.string   "stripe_id"
    t.integer  "amount"
    t.string   "currency"
    t.string   "description"
    t.string   "receipt_email"
    t.string   "statement_descriptor"
    t.integer  "invoice_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "tang_charges", ["invoice_id"], name: "index_tang_charges_on_invoice_id", using: :btree

  create_table "tang_coupons", force: :cascade do |t|
    t.string   "stripe_id"
    t.string   "duration"
    t.integer  "amount_off"
    t.string   "currency"
    t.integer  "duration_in_months"
    t.integer  "max_redemptions"
    t.integer  "percent_off"
    t.datetime "redeem_by"
    t.integer  "redemptions"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "tang_invoices", force: :cascade do |t|
    t.string   "stripe_id"
    t.integer  "subscription_id"
    t.datetime "period_start"
    t.datetime "period_end"
    t.datetime "date"
    t.integer  "total"
    t.string   "currency"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "tang_invoices", ["subscription_id"], name: "index_tang_invoices_on_subscription_id", using: :btree

  create_table "tang_plans", force: :cascade do |t|
    t.string   "stripe_id"
    t.integer  "amount"
    t.string   "currency"
    t.string   "interval"
    t.integer  "interval_count"
    t.string   "name"
    t.string   "statement_descriptor"
    t.integer  "trial_period_days"
    t.integer  "order"
    t.boolean  "highlight",            default: false, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "tang_stripe_webhooks", force: :cascade do |t|
    t.string   "stripe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tang_subscriptions", force: :cascade do |t|
    t.string   "stripe_id"
    t.integer  "customer_id"
    t.integer  "plan_id"
    t.decimal  "application_fee_percent"
    t.integer  "quantity"
    t.decimal  "tax_percent"
    t.datetime "trial_end"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "coupon_id"
  end

  add_index "tang_subscriptions", ["customer_id"], name: "index_tang_subscriptions_on_customer_id", using: :btree
  add_index "tang_subscriptions", ["plan_id"], name: "index_tang_subscriptions_on_plan_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "stripe_id"
    t.integer  "account_balance"
    t.string   "business_vat_id"
    t.string   "currency"
    t.boolean  "delinquent",             default: false, null: false
    t.string   "description"
    t.datetime "active_until"
    t.string   "role"
    t.integer  "coupon_id"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
