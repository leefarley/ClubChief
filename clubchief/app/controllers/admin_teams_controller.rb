class AdminTeamsController < ApplicationController
  before_filter :is_a_club_admin?

#This method will allow the admin to assign memebers to a competition team
  def assign
    if Team.exists?(params[:team_id])
      @team = Team.find(params[:team_id])
      if @team.competition.deadline < Time.now
        if @team.competition.competition_finshed == false
              competition = @team.competition
              @unassigned_applications = competition.competition_applications.where(:assiged_to_team => false)
              @assigned_members =[]
              @assigned_admin = []
              @team.memberships.each do |membership|
          		if membership.admin
          			@assigned_admin << membership
          		else
          			@assigned_members << membership
          		end
          end
        else
          flash[:notice] = "You cannot assign members to a team after its competition is finished"
          redirect_to :controller => 'admin_competitions'
        end
      else
        flash[:notice] = "You cannot assign members to a team before the deadline"  
        redirect_to :controller => 'admin_competitions'
      end
    else
      flash[:alert] = "That team does not exist"
      redirect_to :controller => 'admin_competitions'
    end
  end

# This method will assign a member of the competition to a competition team
  def create_membership
  
    if CompetitionApplication.exists?(params[:application_id])
      if Team.exists?(params[:team_id])      
        application = CompetitionApplication.find(params[:application_id])
        team = Team.find(params[:team_id])      
        if team.memberships.create(:user_id => application.user_id)
          application.update_attributes(:assiged_to_team => true)
          team.add_user_to_current_events(application.user_id)
          flash[:success] = application.user.full_name.to_s + " was successfully added to "+ team.name
        else
          flash[:error] = application.user.full_name.to_s +" was not able to be added to "+ team.name
        end
      else
        flash[:alert] = "That team does not exist"
      end
    else
      flash[:alert] = "That application does not exist"
    end
    redirect_to :back  
  end


#this method will remove a membership from a competition team.
  def remove_membership
  	if Membership.exists?(params[:membership_id])
  	    membership = Membership.find(params[:membership_id])
  	    team = membership.team
  	    user = membership.user
  	    if Membership.delete(membership)
          #change the users application so say that they are not part of a team.
  	      application = CompetitionApplication.find_by_user_id_and_competition_id(user.id, team.competition_id)
  	      application.update_attributes(:assiged_to_team => false)
          #remove the user from any future events for this team.
          team.remove_user_from_current_events(user.id)
  	      flash[:success] = user.full_name.to_s + " was successfully removed from the "+ team.name
  	    else
  	      flash[:error] = "This membership was not able to be deleted"
  	    end
  	  else
  	    flash[:alert] ="That membership does not exist"
  	  end 
  	  redirect_to :back  
  end


#this method will delete a team
  def destroy
    if Team.exists?(params[:team_id])
      team = Team.find(params[:team_id])
      if !team.memberships.any?
        Team.delete(team) 
        flash[:success] = team.name.to_s + " team was successfully removed."
      else
        flash[:alert] = "Cannot delete a team with members in it."
      end
    else
      flash[:alert] = "That team does not exist."
    end
    redirect_to :back
  end
  

  #Assign a player in a team to have admin rights of that team
  def assign_admin
  	if Team.exists?(params[:team_id])
  		if User.exists?(params[:user_id])
  			team = Team.find(params[:team_id])
  			user = User.find(params[:user_id])
  			if membership = user.memberships.where(:team_id => team.id).first()
  				if membership.update_attributes(:admin => true)
  					flash[:success] = "#{user.full_name} has bee assigned admin of team #{team.name}."
  				end
  			else
  				flash[:error] = "#{user.full_name} is not a member of #{team.full_name}."
  			end
  		else
  			flash[:error] = "This User does not exist."
  		end
  	else
  		flash[:error] = "This team does not exist."
  	end
  	redirect_to :back
  end
  
  #this is for admin to manage teams not connected to a competition
  def manage
    @team = Team.find(params[:team_id])
    @admin_team_players = @team.memberships.where(:admin => true).collect{|membership| membership.user }
    @team_players = @team.memberships.where(:admin => false).collect{|membership| membership.user }
    @avalible_players = @team.club.all_member_team.users
    @avalible_players = @avalible_players - @team_players
    @avalible_players = @avalible_players - @admin_team_players
  end
  
  #assign a member of the teams club to the team
  def assign_to_team
  	  if Team.exists?(params[:team_id])
  		if User.exists?(params[:user_id])
  			team = Team.find(params[:team_id])
  			user = User.find(params[:user_id])
  			if user.memberships.where(:team_id => team.id).first()
  				flash[:error] = "#{user.full_name} is already a member of #{team.full_name}."
  			else
  				user.memberships.create(:team_id => team.id)
          team.add_user_to_current_events(user.id)
  			end
  		else
  			flash[:error] = "This User does not exist."
  		end
  	else
  		flash[:error] = "This team does not exist."
  	end
  	redirect_to :back
  end
  
  #remove a memeber from this team
  def unassign_from_team
  	 if User.exists?(params[:user_id])
  	 	if Team.exists?(params[:team_id])
  	    		team = Team.find(params[:team_id])
  	    		user = User.find(params[:user_id])
  	    		membership = Membership.find_by_user_id_and_team_id(user.id,team.id)
  	    		if Membership.delete(membership)
  	      		team.remove_user_from_current_events(user.id)
              flash[:success] = user.full_name.to_s + " was successfully removed from the "+ team.name+ "."
            else
       				flash[:error] = "This membership was not able to be deleted"
  	 		end
  	 	else
  	 		flash[:alert] ="That team does not exist"
  	 	end
  	 else
  	 	flash[:alert] ="That user does not exist"
  	 end 
  	  redirect_to :back  
  end
  
  def rename
        team = Team.find(params[:id])
        team.update_attributes(:name => params[:newName])
        redirect_to :back
  end

end
