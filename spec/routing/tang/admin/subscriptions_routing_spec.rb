require "rails_helper"

module Tang
  RSpec.describe Admin::SubscriptionsController, type: :routing do
    routes { Tang::Engine.routes }
    describe "routing" do

      it "routes to #index" do
        expect(:get => "/admin/subscriptions").to route_to("tang/admin/subscriptions#index")
      end

      it "routes to #show" do
        expect(:get => "/admin/subscriptions/1").to route_to("tang/admin/subscriptions#show", :id => "1")
      end

      it "routes to #edit" do
        expect(:get => "/admin/subscriptions/1/edit").to route_to("tang/admin/subscriptions#edit", :id => "1")
      end

      it "routes to #update via PUT" do
        expect(:put => "/admin/subscriptions/1").to route_to("tang/admin/subscriptions#update", :id => "1")
      end

      it "routes to #update via PATCH" do
        expect(:patch => "/admin/subscriptions/1").to route_to("tang/admin/subscriptions#update", :id => "1")
      end

      it "routes to #destroy" do
        expect(:delete => "/admin/subscriptions/1").to route_to("tang/admin/subscriptions#destroy", :id => "1")
      end

    end
  end
end
