class Team < ActiveRecord::Base

  belongs_to :club
  belongs_to :competition
  has_many   :competition_applications, :through => :competition

  has_many   :memberships

  has_many   :events

  has_many   :attendee_lists

  has_many   :users , :through => :memberships
  has_many   :attendees, :through => :events

  has_many   :notifications

  validates  :club_id , :presence => true

  validates  :name,  :presence => true,
                        :length => {:within => 1..20 }
                      
  validates_associated :club, :memberships, :events, :users

  
  

  def myclub
    self.club_id
  end

  def add_user_to_current_events(user_id)
    events.each do |e|
      #only add the new member to events in the future
      if e.start_at > Date.current
        e.attendees.create(:user_id => user_id)
      end
    end
  end

  def remove_user_from_current_events(user_id)
    Attendee.delete(attendees.where(:user_id => user_id))
  end

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

