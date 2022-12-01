class CreateTangStripeWebhooks < ActiveRecord::Migration[4.2]
  def change
    create_table :tang_stripe_webhooks do |t|
      t.string :stripe_id

      t.timestamps null: false
    end
  end
end
