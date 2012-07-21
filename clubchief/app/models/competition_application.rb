# == Schema Information
#
# Table name: competition_applications
#
#  id              :integer         not null, primary key
#  user_id         :integer         not null
#  competition_id  :integer         not null
#  assiged_to_team :boolean         default(FALSE)
#  created_at      :datetime
#  updated_at      :datetime
#

class CompetitionApplication < ActiveRecord::Base
  belongs_to :user
  belongs_to :competition
end



