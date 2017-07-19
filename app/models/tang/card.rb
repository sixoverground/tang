module Tang
  class Card < ActiveRecord::Base
    belongs_to :customer, class_name: Tang.customer_class.to_s

    validates :customer, presence: true, uniqueness: true
    validates :stripe_id, presence: true, uniqueness: true
    validates :name, presence: true
    validates :last4, numericality: { only_integer: true, greater_than_or_equal_to: 0 },
                      length: { is: 4 }
    validates :exp_month, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
    validates :exp_year, numericality: { only_integer: true, greater_than_or_equal_to: Date.today.year - 30.years, less_than_or_equal_to: Date.today.year + 70.years }
    # validates :address_zip, format: { with: /\A\d{5}(-\d{4})?\z/ }
    validates :address_zip, presence: true

    def update_from_stripe(stripe_card)
      self.stripe_id = stripe_card.id
      self.address_city = stripe_card.address_city
      self.address_country = stripe_card.address_country
      self.address_line1 = stripe_card.address_line1
      self.address_line1_check = stripe_card.address_line1_check
      self.address_line2 = stripe_card.address_line2
      self.address_state = stripe_card.address_state
      self.address_zip = stripe_card.address_zip
      self.address_zip_check = stripe_card.address_zip_check
      self.brand = stripe_card.brand
      self.country = stripe_card.country
      self.cvc_check = stripe_card.cvc_check
      # self.dynamic_last4 = stripe_card.dynamic_last4
      self.exp_month = stripe_card.exp_month
      self.exp_year = stripe_card.exp_year
      self.fingerprint = stripe_card.fingerprint
      self.funding = stripe_card.funding
      self.last4 = stripe_card.last4
      self.name = stripe_card.name
      # self.tokenization_method = stripe_card.tokenization_method
      self.save(validate: false)
    end

    def self.from_stripe(stripe_card, customer)
      card = Card.find_or_initialize_by(stripe_id: stripe_card.id) do |c|
        c.customer = customer
        c.address_city = stripe_card.address_city
        c.address_country = stripe_card.address_country
        c.address_line1 = stripe_card.address_line1
        c.address_line1_check = stripe_card.address_line1_check
        c.address_line2 = stripe_card.address_line2
        c.address_state = stripe_card.address_state
        c.address_zip = stripe_card.address_zip
        c.address_zip_check = stripe_card.address_zip_check
        c.brand = stripe_card.brand
        c.country = stripe_card.country
        c.cvc_check = stripe_card.cvc_check
        c.dynamic_last4 = stripe_card.dynamic_last4
        c.exp_month = stripe_card.exp_month
        c.exp_year = stripe_card.exp_year
        c.funding = stripe_card.funding
        c.last4 = stripe_card.last4
        c.name = stripe_card.name
        c.tokenization_method = stripe_card.tokenization_method
      end
      card.save(validate: false) if card.new_record?
      return card
    end
  end
end
