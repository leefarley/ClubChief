class AddCompetitionApplications < ActiveRecord::Migration
  def self.up
	
	Membership.find(:all).each { |membership| 
		membership.user.competition_applications.create(:competition_id => membership.team.competition_id, :assiged_to_team => true) if membership.team.club_team == false }	
  	end

  def self.down

  end
end
