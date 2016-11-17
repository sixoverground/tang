module Tang
  class InvoiceItem < ActiveRecord::Base
    belongs_to :invoice
    belongs_to :plan
    belongs_to :subscription
  end
end
