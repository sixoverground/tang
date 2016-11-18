module Tang
  class ImportStripeJob < ActiveJob::Base
    queue_as :default

    def perform
      # Do something later
      ImportPlansJob.perform_now
      ImportCouponsJob.perform_now
      ImportCustomersJob.perform_now
      ImportSubscriptionsJob.perform_now
      ImportInvoicesJob.perform_now
      ImportChargesJob.perform_now
    end
  end
end
