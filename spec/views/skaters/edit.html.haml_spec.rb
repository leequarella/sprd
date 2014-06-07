require 'rails_helper'

RSpec.describe "skaters/edit", :type => :view do
  before(:each) do
    @skater = assign(:skater, Skater.create!(
      :first_name => "MyString",
      :last_name => "MyString",
      :derby_name => "MyString",
      :email => "MyString"
    ))
  end

  it "renders the edit skater form" do
    render

    assert_select "form[action=?][method=?]", skater_path(@skater), "post" do

      assert_select "input#skater_first_name[name=?]", "skater[first_name]"

      assert_select "input#skater_last_name[name=?]", "skater[last_name]"

      assert_select "input#skater_derby_name[name=?]", "skater[derby_name]"

      assert_select "input#skater_email[name=?]", "skater[email]"
    end
  end
end
