class Club < ActiveRecord::Base

	@@per_page = 1
  attr_readonly :id
  attr_accessible :name, :description, :sport_id ,:street_address, :suburb, :town_city_id
# the club can currently only have one sport
  belongs_to :sport
  
  belongs_to :town_city

# the club can have many teams that are made up of their members
  has_many :teams
  has_many :events , :through => :teams
  
  has_many :memberships, :through => :teams

#  this association allows the club to send notifications to all its members

  has_many :competitions
  has_many :competition_applications, :through => :competitions


  validates :name, :presence => true,
                   :length => {:within => 5..40,
                               :too_short=>'club name needs to be more descriptive',
                               :too_long => 'club name cannot exceed 40 characters'}

  validates :description, :presence => true, :length=>{:within => 5..256}

  validates :sport_id, :presence => true,
                       :numericality => {:greater_than => 0}

 def all_member_team
   return teams.where(:club_team => true).first
 end
 
   def new_membership(user_id)
  	    user = User.find(user_id)
    	if  user.is_member_of?(self.id)
        	flash[:error] = "Already a member of  "+club.name
    	else
      		team = self.all_member_team
      		membership = team.memberships.new
      		membership.user = user
      		if  membership.save
          		flash[:notice] = "Successfully added "+club.name+" to your profile"
                #foreach event in the team create a attendee row in the database for the new member
                team.events.each do |event|
                    #finding all the events in the future
                	if (event.start_at > DateTime.current)
                  		event.attendees.create(:user_id => user.id)
                	end
              end
        	else
         	 	flash[:error] = "Unable to add the club to your profile"
        	end
    	end
    	redirect_to clubs_path
   end

  def remove_all_associations

    self.events.each do |e|
      Attendee.delete(e.attendees)
    end

    Event.delete(self.events)
    teams = self.teams
    teams.each do |team|
      if team.competition_id.blank?  == false
        CompetitionApplication.delete(team.competition.competition_applications)
      end
      Notification.delete(team.notifications)
    end

    Competition.delete(self.competitions)

    Membership.delete(self.memberships)
    Team.delete(self.teams)
  end
  
  def users
 	  return all_member_team.users
 end

end

# == Schema Information
#
# Table name: clubs
#
#  id             :integer         not null, primary key
#  name           :string(255)     not null
#  description    :text
#  sport_id       :integer
#  street_address :text
#  suburb         :text
#  town_city_id   :integer
#  created_at     :datetime
#  updated_at     :datetime
#

