require "spec_helper"

describe AttendeeListsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/attendee_lists" }.should route_to(:controller => "attendee_lists", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/attendee_lists/new" }.should route_to(:controller => "attendee_lists", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/attendee_lists/1" }.should route_to(:controller => "attendee_lists", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/attendee_lists/1/edit" }.should route_to(:controller => "attendee_lists", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/attendee_lists" }.should route_to(:controller => "attendee_lists", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/attendee_lists/1" }.should route_to(:controller => "attendee_lists", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/attendee_lists/1" }.should route_to(:controller => "attendee_lists", :action => "destroy", :id => "1")
    end

  end
end
