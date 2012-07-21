require 'spec_helper'

describe Competition do
  pending "add some examples to (or delete) #{__FILE__}"
end



# == Schema Information
#
# Table name: competitions
#
#  id                  :integer         not null, primary key
#  name                :string(255)     not null
#  deadline            :datetime        not null
#  club_id             :integer         not null
#  competition_finshed :boolean         default(FALSE)
#  description         :text
#  created_at          :datetime
#  updated_at          :datetime
#

