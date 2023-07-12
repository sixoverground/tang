require_dependency 'tang/application_controller'

module Tang
  class Account::CardsController < Account::ApplicationController
    before_action :set_card, only: [:show, :destroy]

    def show
      @can_delete_card = current_customer.stripe_id.present? &&
                         current_customer.subscription.nil? &&
                         @card.present?
    end

    def new
      @card = Card.new(
        customer: current_customer
      )
    end

    def create
      @card = SaveCard.call(
        current_customer,
        params[:stripe_token]
      )

      if @card.errors.blank?
        redirect_to account_card_path, notice: 'Card was successfully created.'
      else
        render :new
      end
    end

    def update
      @card = SaveCard.call(
        current_customer,
        params[:stripe_token]
      )

      if @card.errors.blank?
        redirect_to account_card_path, notice: 'Card was successfully created.'
      else
        render :new
      end
    end

    def destroy
      if current_customer.subscription.nil?
        if @card.present?
          @card.destroy
          redirect_to account_card_url, notice: 'Card was successfully removed.'
        else
          redirect_to account_card_url, notice: 'We could not find a card to remove.'
        end
      else
        redirect_to account_card_url, notice: 'You cannot remove your card with an active subscription.'
      end
    end

    private

    def set_card
      @card = current_customer.card
    end
  end
end
