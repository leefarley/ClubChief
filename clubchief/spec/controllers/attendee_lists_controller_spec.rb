require 'spec_helper'

describe AttendeeListsController do

  def mock_attendee_list(stubs={})
    (@mock_attendee_list ||= mock_model(AttendeeList).as_null_object).tap do |attendee_list|
      attendee_list.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all attendee_lists as @attendee_lists" do
      AttendeeList.stub(:all) { [mock_attendee_list] }
      get :index
      assigns(:attendee_lists).should eq([mock_attendee_list])
    end
  end

  describe "GET show" do
    it "assigns the requested attendee_list as @attendee_list" do
      AttendeeList.stub(:find).with("37") { mock_attendee_list }
      get :show, :id => "37"
      assigns(:attendee_list).should be(mock_attendee_list)
    end
  end

  describe "GET new" do
    it "assigns a new attendee_list as @attendee_list" do
      AttendeeList.stub(:new) { mock_attendee_list }
      get :new
      assigns(:attendee_list).should be(mock_attendee_list)
    end
  end

  describe "GET edit" do
    it "assigns the requested attendee_list as @attendee_list" do
      AttendeeList.stub(:find).with("37") { mock_attendee_list }
      get :edit, :id => "37"
      assigns(:attendee_list).should be(mock_attendee_list)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created attendee_list as @attendee_list" do
        AttendeeList.stub(:new).with({'these' => 'params'}) { mock_attendee_list(:save => true) }
        post :create, :attendee_list => {'these' => 'params'}
        assigns(:attendee_list).should be(mock_attendee_list)
      end

      it "redirects to the created attendee_list" do
        AttendeeList.stub(:new) { mock_attendee_list(:save => true) }
        post :create, :attendee_list => {}
        response.should redirect_to(attendee_list_url(mock_attendee_list))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved attendee_list as @attendee_list" do
        AttendeeList.stub(:new).with({'these' => 'params'}) { mock_attendee_list(:save => false) }
        post :create, :attendee_list => {'these' => 'params'}
        assigns(:attendee_list).should be(mock_attendee_list)
      end

      it "re-renders the 'new' template" do
        AttendeeList.stub(:new) { mock_attendee_list(:save => false) }
        post :create, :attendee_list => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested attendee_list" do
        AttendeeList.should_receive(:find).with("37") { mock_attendee_list }
        mock_attendee_list.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :attendee_list => {'these' => 'params'}
      end

      it "assigns the requested attendee_list as @attendee_list" do
        AttendeeList.stub(:find) { mock_attendee_list(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:attendee_list).should be(mock_attendee_list)
      end

      it "redirects to the attendee_list" do
        AttendeeList.stub(:find) { mock_attendee_list(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(attendee_list_url(mock_attendee_list))
      end
    end

    describe "with invalid params" do
      it "assigns the attendee_list as @attendee_list" do
        AttendeeList.stub(:find) { mock_attendee_list(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:attendee_list).should be(mock_attendee_list)
      end

      it "re-renders the 'edit' template" do
        AttendeeList.stub(:find) { mock_attendee_list(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested attendee_list" do
      AttendeeList.should_receive(:find).with("37") { mock_attendee_list }
      mock_attendee_list.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the attendee_lists list" do
      AttendeeList.stub(:find) { mock_attendee_list }
      delete :destroy, :id => "1"
      response.should redirect_to(attendee_lists_url)
    end
  end

end
