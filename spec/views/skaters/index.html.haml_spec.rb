require 'rails_helper'

RSpec.describe "skaters/index", :type => :view do
  before(:each) do
    assign(:skaters, [
      Skater.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :derby_name => "Derby Name",
        :email => "Email"
      ),
      Skater.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :derby_name => "Derby Name",
        :email => "Email"
      )
    ])
  end

  it "renders a list of skaters" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Derby Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
