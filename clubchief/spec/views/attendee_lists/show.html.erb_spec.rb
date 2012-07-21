require 'spec_helper'

describe "attendee_lists/show.html.erb" do
  before(:each) do
    @attendee_list = assign(:attendee_list, stub_model(AttendeeList,
      :event_id => 1,
      :team_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
