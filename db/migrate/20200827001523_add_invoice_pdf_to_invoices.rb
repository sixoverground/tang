class AddInvoicePdfToInvoices < ActiveRecord::Migration
  def change
    add_column :tang_invoices, :invoice_pdf, :string
  end
end
