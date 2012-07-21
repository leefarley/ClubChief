require 'spec_helper'

describe Membership do
  before(:each) do
     user = Factory(:user)
     club = Factory(:club)
     @attr = {:club_id => club, :user_id => user}
  end

  it "should be successful" do
     membership = Membership.create!(@attr)
     membership.should be_valid
  end
end

# == Schema Information
#
# Table name: memberships
#
#  id         :integer         not null, primary key
#  user_id    :integer         not null
#  team_id    :integer         not null
#  admin      :boolean         default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

