require 'spec_helper'

describe Team do
  pending "add some examples to (or delete) #{__FILE__}"
end




# == Schema Information
#
# Table name: teams
#
#  id             :integer         not null, primary key
#  name           :string(255)     not null
#  club_id        :integer         not null
#  club_team      :boolean         default(FALSE)
#  competition_id :integer
#  max_players    :integer
#  created_at     :datetime
#  updated_at     :datetime
#

