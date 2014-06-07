require 'rails_helper'

RSpec.describe "skaters/show", :type => :view do
  before(:each) do
    @skater = assign(:skater, Skater.create!(
      :first_name => "First Name",
      :last_name => "Last Name",
      :derby_name => "Derby Name",
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Derby Name/)
    expect(rendered).to match(/Email/)
  end
end
