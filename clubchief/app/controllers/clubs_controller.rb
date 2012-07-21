require 'will_paginate/array'
class ClubsController < ApplicationController

  before_filter :authorize

  def index
      user = get_current_user
      user_clubs = user.teams.where(:club_team => true).collect{|t| t.club}
	  @clubs = Club.all
	  @clubs = @clubs - user_clubs
  end

  def my_index
    	user = get_current_user
    	@clubs = user.teams.where(:club_team => true).collect{|t| t.club}
  end

  def apply
    	user = get_current_user
    	club = Club.find(params[:id])
    	if  user.is_member_of?(club.id)
        	flash[:alert] = "You have already added "+club.name+" to your profile"
    	else
      		team = club.teams.where(:club_team => true).first
      		membership = user.memberships.new
      		membership.team = team
      		if  membership.save
          		flash[:success] = "Successfully added "+club.name+" to your profile"
              #foreach event in the team create a attendee row in the database for the new member
              team.add_user_to_current_events(user)
        	else
         	 	flash[:alert] = "Unable to add the club to your profile"
        	end
    	end
    	redirect_to my_clubs_path
  end

  def remove
   	club = Club.find(params[:id])
   	user = get_current_user
   	teams = club.teams
	
	teams.each do |team|
		#remove any events from the users teams
		if team.events.any?
			Attendee.delete(team.attendees.where(:user_id => user.id))	
		end
	
		#remove any competition_applications
	 	if team.competition_id != nil
	  		CompetitionApplication.delete(team.competition_applications.where(:user_id => user.id))
	  	end 
		
		if membership = team.memberships.find_by_user_id(user.id)
      			#and try to delete the membership
        		if Membership.delete(membership)
				flash[:success] = "You have successfully been removed from #{club.name}"
        		end
        	end
    end
    redirect_to :back
  end
  
  def new
    @club = Club.new
    @sports = Sport.all.sort_by{|sport| sport.sport_name}
    @towncity = TownCity.all.sort_by{|town| town.name}
  end
  
  def create
  	@club = Club.new(params[:club])
  	success = false
  	if @club.save
  		team = @club.teams.new()
      team.name = @club.name
      team.club_team = true
  		if team.save
  			membership = team.memberships.new(:user_id => get_current_user_id, :admin => true)
  			if membership.save
          UserMailer.register_club(@club).deliver
  				success = true
  				flash[:success] = @club.name + " has successfully been registered."
  				redirect_to my_clubs_path
  			end
  		end
  	end
  	
  	if success == false
    @sports = Sport.all.sort_by{|sport| sport.sport_name}
    @towncity = TownCity.all.sort_by{|town| town.name}
    	render "new"
    end
  end
  
  def edit
    @club = Club.find(params[:id])
    @sports = Sport.all.sort_by{|sport| sport.sport_name}
    @towncity = TownCity.all.sort_by{|town| town.name}
  end
  
  def update
  	@club =  Club.find(params[:id])
  	name = @club.name
  	if @club.update_attributes!(params[:club])
  		if name != @club.name
  		# if the name has changed we need to change the name of the club_team
  			@team = @club.teams.where(:club_team => true).first
  			@team.update_attributes(:name => @club.name)

  			flash[:success] = @team.name + "  " + @club.name
  		end
  		redirect_to :action => :my_index
  	else
    @sports = Sport.all.sort_by{|sport| sport.sport_name}
    @towncity = TownCity.all.sort_by{|town| town.name}
  		render "edit"
  	end
  end

  def destroy
  	if Club.exists?(params[:id])
  		club = Club.find(params[:id])
      #delete any memberships, teams, events, competitions form this club
      club.remove_all_associations
      #delete the club
      Team.delete(club.teams)
      if Club.delete(club)
        flash[:success] = "Successfully deleted "+ club.name
      else
        flash[:alert] = "Unable to remove "+ club.name
      end

  	else
  		flash[:alert] = "Club does not exist."
    end
    redirect_to :back
  end

end
