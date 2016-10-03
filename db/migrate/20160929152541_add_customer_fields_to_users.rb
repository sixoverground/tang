class AddCustomerFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_id, :string
    add_column :users, :account_balance, :integer
    add_column :users, :business_vat_id, :string
    add_column :users, :currency, :string
    add_column :users, :delinquent, :boolean, null: false, default: false
    add_column :users, :description, :string
    add_column :users, :active_until, :timestamp
  end
end
