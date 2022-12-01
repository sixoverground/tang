class AddInvoicePdfToInvoices < ActiveRecord::Migration[4.2]
  def change
    add_column :tang_invoices, :invoice_pdf, :string
  end
end
