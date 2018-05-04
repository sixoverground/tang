module Tang
  class Charge < ActiveRecord::Base
    include AASM
    has_paper_trail

    aasm column: 'status' do
      state :pending, initial: true
      state :succeeded
      state :failed

      event :succeed do
        transitions from: :pending, to: :succeeded
      end

      event :fail do
        transitions from: :pending, to: :failed
      end
    end

    belongs_to :invoice
    has_one :subscription, through: :invoice
    has_one :customer, through: :invoice
    has_one :card, through: :customer

    validates :invoice, presence: true
    validates :stripe_id, presence: true, uniqueness: true
    validates :amount, numericality: { only_integer: true, greater_than_or_equal_to: 50 }
    validates :currency, presence: true
    validates :statement_descriptor, length: { maximum: 22 }, format: { without: /[<>"']/ }, allow_nil: true

    def self.from_stripe(stripe_charge, invoice)
      Charge.find_or_create_by(stripe_id: stripe_charge.id) do |c|
        c.invoice = invoice
        c.amount = stripe_charge.amount
        c.currency = stripe_charge.currency
        c.description = stripe_charge.description
        c.receipt_email = stripe_charge.receipt_email
        c.statement_descriptor = stripe_charge.statement_descriptor

        # Save payment source directly to charge
        c.set_source(stripe_charge.source)

        # c.card_stripe_id = stripe_charge.source.id
        # c.card_address_city = stripe_charge.source.address_city
        # c.card_address_country = stripe_charge.source.address_country
        # c.card_address_line1 = stripe_charge.source.address_line1
        # c.card_address_line1_check = stripe_charge.source.address_line1_check
        # c.card_address_line2 = stripe_charge.source.address_line2
        # c.card_address_state = stripe_charge.source.address_state
        # c.card_address_zip = stripe_charge.source.address_zip
        # c.card_address_zip_check = stripe_charge.source.address_zip_check
        # c.card_brand = stripe_charge.source.brand
        # c.card_country = stripe_charge.source.country
        # c.card_cvc_check = stripe_charge.source.cvc_check
        # # c.card_dynamic_last4 = stripe_charge.source.dynamic_last4
        # c.card_exp_month = stripe_charge.source.exp_month
        # c.card_exp_year = stripe_charge.source.exp_year
        # c.card_fingerprint = stripe_charge.source.fingerprint
        # c.card_funding = stripe_charge.source.funding
        # c.card_last4 = stripe_charge.source.last4
        # c.card_name = stripe_charge.source.name
        # # c.card_tokenization_method = stripe_charge.source.tokenization_method
      
        c.created = DateTime.strptime(stripe_charge.created.to_s, '%s')
        c.status = stripe_charge.status
      end
    end

    def self.search(query)
      charges = Charge.none
      if query.present?
        q = "%#{query.downcase}%"
        customer_table = connection.quote_table_name(Customer.table_name)
        charges = Charge.joins(:customer).
            where("lower(tang_charges.stripe_id) like ? or lower(#{customer_table}.stripe_id) like ?",
                q, q).
            distinct
      end
      return charges
    end

    def set_source(source)
      self.card_stripe_id = source.id
      self.card_address_city = source.address_city
      self.card_address_country = source.address_country
      self.card_address_line1 = source.address_line1
      self.card_address_line1_check = source.address_line1_check
      self.card_address_line2 = source.address_line2
      self.card_address_state = source.address_state
      self.card_address_zip = source.address_zip
      self.card_address_zip_check = source.address_zip_check
      self.card_brand = source.brand
      self.card_country = source.country
      self.card_cvc_check = source.cvc_check
      # self.card_dynamic_last4 = source.dynamic_last4
      self.card_exp_month = source.exp_month
      self.card_exp_year = source.exp_year
      self.card_fingerprint = source.fingerprint
      self.card_funding = source.funding
      self.card_last4 = source.last4
      self.card_name = source.name
      # self.card_tokenization_method = source.tokenization_method
    end
  end
end
