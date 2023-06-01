class AddEnableCustomerEmails < ActiveRecord::Migration[6.1]
  def change
    add_column Tang.customer_class.to_s.downcase.pluralize, :enable_customer_payment_success_emails, :boolean, null: false, default: true
    add_column Tang.customer_class.to_s.downcase.pluralize, :enable_customer_payment_failed_emails, :boolean, null: false, default: true
  end
end
