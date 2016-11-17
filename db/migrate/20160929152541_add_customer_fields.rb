class AddCustomerFields < ActiveRecord::Migration
  def change
    add_column Tang.customer_class.to_s.downcase.pluralize, :stripe_id, :string
    add_column Tang.customer_class.to_s.downcase.pluralize, :account_balance, :integer
    add_column Tang.customer_class.to_s.downcase.pluralize, :business_vat_id, :string
    add_column Tang.customer_class.to_s.downcase.pluralize, :currency, :string
    add_column Tang.customer_class.to_s.downcase.pluralize, :delinquent, :boolean, null: false, default: false
    add_column Tang.customer_class.to_s.downcase.pluralize, :description, :string
    add_column Tang.customer_class.to_s.downcase.pluralize, :active_until, :timestamp
    add_column Tang.customer_class.to_s.downcase.pluralize, :coupon_id, :integer, index: true, foreign_key: true
  end
end
