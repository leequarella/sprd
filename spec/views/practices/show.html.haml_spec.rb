require 'rails_helper'

RSpec.describe "practices/show", :type => :view do
  before(:each) do
    @practice = assign(:practice, Practice.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
