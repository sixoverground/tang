module Tang
  class ImportChargesJob < ActiveJob::Base
    queue_as :default

    def perform
      # Do something later
      Stripe::Charge.list.each do |stripe_charge|

        invoice = Invoice.find_by(stripe_id: stripe_charge.invoice)

        if invoice.present?
          Charge.find_or_create_by(stripe_id: stripe_charge.id) do |c|
            c.invoice = invoice
            c.amount = stripe_charge.amount
            c.currency = stripe_charge.currency
            c.description = stripe_charge.description
            c.receipt_email = stripe_charge.receipt_email
            c.statement_descriptor = stripe_charge.statement_descriptor

            # Save payment source directly to charge
            c.card_stripe_id = stripe_charge.source.id
            c.card_address_city = stripe_charge.source.address_city
            c.card_address_country = stripe_charge.source.address_country
            c.card_address_line1 = stripe_charge.source.address_line1
            c.card_address_line1_check = stripe_charge.source.address_line1_check
            c.card_address_line2 = stripe_charge.source.address_line2
            c.card_address_state = stripe_charge.source.address_state
            c.card_address_zip = stripe_charge.source.address_zip
            c.card_address_zip_check = stripe_charge.source.address_zip_check
            c.card_brand = stripe_charge.source.brand
            c.card_country = stripe_charge.source.country
            c.card_cvc_check = stripe_charge.source.cvc_check
            c.card_dynamic_last4 = stripe_charge.source.dynamic_last4
            c.card_exp_month = stripe_charge.source.exp_month
            c.card_exp_year = stripe_charge.source.exp_year
            c.card_fingerprint = stripe_charge.source.fingerprint
            c.card_funding = stripe_charge.source.funding
            c.card_last4 = stripe_charge.source.last4
            c.card_name = stripe_charge.source.name
            c.card_tokenization_method = stripe_charge.source.tokenization_method
          end
        end

      end
    end
  end
end
