require 'spec_helper'

describe HomeController do

  describe "GET 'main'" do
    it "should be successful" do
      get :main
      response.should be_success
    end
  end

  describe "GET 'login'" do
    it "should be successful" do
      get :login
      response.should be_success
    end
  end

end
