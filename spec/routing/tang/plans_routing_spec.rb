require "rails_helper"

module Tang
  RSpec.describe PlansController, type: :routing do

    routes { Tang::Engine.routes }

    describe "routing" do

      it "routes to #index" do
        expect(:get => "/plans").to route_to("tang/plans#index")
      end

      it "routes to #new" do
        expect(:get => "/plans/new").to route_to("tang/plans#new")
      end

      it "routes to #show" do
        expect(:get => "/plans/1").to route_to("tang/plans#show", :id => "1")
      end

      it "routes to #edit" do
        expect(:get => "/plans/1/edit").to route_to("tang/plans#edit", :id => "1")
      end

      it "routes to #create" do
        expect(:post => "/plans").to route_to("tang/plans#create")
      end

      it "routes to #update via PUT" do
        expect(:put => "/plans/1").to route_to("tang/plans#update", :id => "1")
      end

      it "routes to #update via PATCH" do
        expect(:patch => "/plans/1").to route_to("tang/plans#update", :id => "1")
      end

      it "routes to #destroy" do
        expect(:delete => "/plans/1").to route_to("tang/plans#destroy", :id => "1")
      end

    end
  end
end
