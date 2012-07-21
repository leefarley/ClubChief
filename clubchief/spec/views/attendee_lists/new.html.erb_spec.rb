require 'spec_helper'

describe "attendee_lists/new.html.erb" do
  before(:each) do
    assign(:attendee_list, stub_model(AttendeeList,
      :event_id => 1,
      :team_id => 1
    ).as_new_record)
  end

  it "renders new attendee_list form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => attendee_lists_path, :method => "post" do
      assert_select "input#attendee_list_event_id", :name => "attendee_list[event_id]"
      assert_select "input#attendee_list_team_id", :name => "attendee_list[team_id]"
    end
  end
end
