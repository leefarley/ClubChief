require 'spec_helper'

describe ClubNotification do
  before(:each) do
     @attr = {:message => "this is a club message", :club_id => Factory(:club), :user_id => Factory(:user)}
  end

  it "should be successful" do
    notification = ClubNotification.create(@attr)
    notification.should be_valid
  end

  it "should have a message" do
    notification = ClubNotification.create(@attr.merge(:message => nil))
    notification.should_not be_valid
  end

  it "should have a message that is descriptive" do
    notification = ClubNotification.create(@attr.merge(:message => "message"))
    notification.should_not be_valid
  end

   it "should have a message that is not too long to store" do
    notification = ClubNotification.create(@attr.merge(:message => "a" * 257))
    notification.should_not be_valid
  end
end
