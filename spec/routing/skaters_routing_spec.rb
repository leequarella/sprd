require "rails_helper"

RSpec.describe SkatersController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/skaters").to route_to("skaters#index")
    end

    it "routes to #new" do
      expect(:get => "/skaters/new").to route_to("skaters#new")
    end

    it "routes to #show" do
      expect(:get => "/skaters/1").to route_to("skaters#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/skaters/1/edit").to route_to("skaters#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/skaters").to route_to("skaters#create")
    end

    it "routes to #update" do
      expect(:put => "/skaters/1").to route_to("skaters#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/skaters/1").to route_to("skaters#destroy", :id => "1")
    end

  end
end
