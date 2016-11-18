module Tang
  class ImportStripeJob < ActiveJob::Base
    queue_as :default

    def perform
      # Do something later
      ImportCouponsJob.perform_now
      ImportInvoicesJob.perform_now
      ImportChargesJob.perform_now
    end
  end
end
