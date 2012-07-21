# == Schema Information
# Schema version: 20110412013906
#
# Table name: sports
#
#  id         :integer         not null, primary key
#  sport_name :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Sport < ActiveRecord::Base
  attr_accessible :sport_name
#  the leagues that are plying this sport.
#  has_many :leagues

#  the clubs that play this sport
  has_many :clubs

  validates :sport_name, :presence => true

end
