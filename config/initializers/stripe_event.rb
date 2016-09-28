require 'stripe_event'

StripeEvent.event_retriever = lambda do |params|
  return nil if Tang::StripeWebhook.exists?(stripe_id: params[:id])
  Tang::StripeWebhook.create!(stripe_id: params[:id])
  Stripe::Event.retrieve(params[:id])
end

StripeEvent.configure do |events|
  events.all do |event|
    logger.debug "stripe_event: #{event}"
  end
end