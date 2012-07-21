require 'spec_helper'

describe Sport do
  before(:each) do
     @attr = {:sport_name => "foo bar"}
  end

  it "should be successful" do
     sport = Sport.create!(@attr)
     sport.should be_valid
  end

  it "should not have a valid name" do
     sport = Sport.new(@attr.merge(:sport_name => ""))
     sport.should_not be_valid
  end
end

# == Schema Information
#
# Table name: sports
#
#  id         :integer         not null, primary key
#  sport_name :string(255)
#  created_at :datetime
#  updated_at :datetime
#

