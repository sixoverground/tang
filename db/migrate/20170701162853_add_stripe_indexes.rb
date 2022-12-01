class AddStripeIndexes < ActiveRecord::Migration[4.2]
  def change
    add_index Tang.customer_class.to_s.downcase.pluralize, :stripe_id, unique: true
    add_index :tang_cards, :stripe_id, unique: true
    add_index :tang_charges, :stripe_id, unique: true
    add_index :tang_coupons, :stripe_id, unique: true
    add_index :tang_invoices, :stripe_id, unique: true
    add_index :tang_invoice_items, :stripe_id, unique: true
    add_index :tang_plans, :stripe_id, unique: true
    add_index :tang_stripe_webhooks, :stripe_id, unique: true
    add_index :tang_subscriptions, :stripe_id, unique: true
  end
end
