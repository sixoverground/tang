module Tang
  class Charge < ActiveRecord::Base
    belongs_to :invoice
    has_one :subscription, through: :invoice
    has_one :customer, through: :subscription
    has_one :card, through: :customer

    validates :invoice, presence: true
    validates :stripe_id, presence: true, uniqueness: true
    validates :amount, numericality: { only_integer: true, greater_than_or_equal_to: 50 }
    validates :currency, presence: true
    validates :statement_descriptor, length: { maximum: 22 }, format: { without: /[<>"']/ }, allow_nil: true
  end
end
