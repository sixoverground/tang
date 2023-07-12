class AddEnableCustomerEmails < ActiveRecord::Migration[6.1]
  def change
    add_column Tang.customer_class.to_s.downcase.pluralize, :customer_payment_success_emails_enabled, :boolean, null: false, default: true
    add_column Tang.customer_class.to_s.downcase.pluralize, :customer_payment_failed_emails_enabled, :boolean, null: false, default: true
  end
end
