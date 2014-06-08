require 'rails_helper'

RSpec.describe ReportsController, :type => :controller do
  describe "GET attendence_percentage" do
    it 'instantiates a new attendence_percentage_report' do
      get :attendence_percentage, start_date: Time.now, end_date: Time.now
      expect(assigns[:report]).to be_a AttendencePercentageReport
    end

    it 'renders the attendence_percentage template' do
      get :attendence_percentage, start_date: Time.now, end_date: Time.now
      expect(response).to render_template :attendence_percentage
    end
  end

end
