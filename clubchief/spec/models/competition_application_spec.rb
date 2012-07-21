require 'spec_helper'

describe CompetitionApplication do
  pending "add some examples to (or delete) #{__FILE__}"
end

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

