require 'spec_helper'

describe "attendee_lists/index.html.erb" do
  before(:each) do
    assign(:attendee_lists, [
      stub_model(AttendeeList,
        :event_id => 1,
        :team_id => 1
      ),
      stub_model(AttendeeList,
        :event_id => 1,
        :team_id => 1
      )
    ])
  end

  it "renders a list of attendee_lists" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
