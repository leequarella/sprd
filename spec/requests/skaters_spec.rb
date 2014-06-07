require 'rails_helper'

RSpec.describe "Skaters", :type => :request do
  describe "GET /skaters" do
    it "works! (now write some real specs)" do
      get skaters_path
      expect(response.status).to be(200)
    end
  end
end
