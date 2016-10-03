require_dependency "tang/application_controller"

module Tang
  class Account::CardsController < Account::ApplicationController
    before_action :set_card, only: [:show]
    
    def show
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

    private

    def set_card
      @card = current_customer.card
    end

    def card_params
      params
    end
  end
end
