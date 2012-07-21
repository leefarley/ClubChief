# == Schema Information
# Schema version: 20110526020528
#
# Table name: events
#
#  id         :integer         not null, primary key
#  name       :string(255)     not null
#  message    :text            not null
#  start_at   :datetime        not null
#  end_at     :datetime        not null
#  team_id    :integer         not null
#  user_id    :integer         not null
#  created_at :datetime
#  updated_at :datetime
#

class Event < ActiveRecord::Base
  has_event_calendar

  attr_accessible :user_id, :end_at, :start_at, :message, :name, :team_id

  belongs_to :team
  belongs_to :user

  has_many  :attendees

  validates :name,:presence => true,
                 :length => {:within => 1..30 }
                 
  validates :message, :presence => true,
                      :length => {:within => 5..256}
  
  validates :start_at,
  			:date => { :after => Time.now , :message => "Your event needs to begin in the future" },
  			:presence => true
  			
  validates :end_at,
  			:date => { :after => :start_at, :message => "Your event needs to begin before it ends" },
  			:presence => true

  validates :team_id,
                     :numericality => {:greater_than => 0, :message => "Please select a team"}
                     
  validates :user_id,:presence => true,
                     :numericality => {:greater_than => 0}

end
