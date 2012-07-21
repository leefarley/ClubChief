class Membership < ActiveRecord::Base
#  attr_readonly :club_id, :user_id, :admin

  attr_accessible :team_id, :user_id, :admin

  belongs_to :team

  belongs_to :user

 def club_id
 	return team.club_id
 end

 def club
 	return team.club
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

