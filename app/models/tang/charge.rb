module Tang
  class Charge < ActiveRecord::Base
    belongs_to :invoice
    has_one :subscription, through: :invoice
    has_one :customer, through: :subscription
    has_one :card, through: :customer
  end
end
