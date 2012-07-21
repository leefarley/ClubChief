class TownCity < ActiveRecord::Base

has_many :clubs

end

# == Schema Information
#
# Table name: town_cities
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

