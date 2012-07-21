class TeamsController < ApplicationController
before_filter :authorize, :only => [:index]
before_filter :is_a_club_admin?, :except => [:index]

  def index
    @user = get_current_user
    teams = @user.get_manageable_teams
    @manageable_teams = teams.select{|team|team.club_team == false }
    @teams = @user.get_teams - @manageable_teams
    #have to remove the club teams from the teams array
  end

	def new
    @clubs = get_admin_clubs
    @team = Team.new
	end
	
	
  def create
    @team = Team.new(params[:team])
    if !@team.name.empty?
      if @team.save
        flash[:success] = "You have successfully created team '"+@team.name+"'"
        redirect_to teams_path
      else
        flash[:alert] = "Your new team was not able to be saved"
         redirect_to :back
      end
    else
      flash[:alert] = "A new team needs to have a name"
      redirect_to :back
    end
  end

  def edit
     @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
  	if @team.update_attributes(params[:club])
  			flash[:success] = @team.name + " updated"
  		redirect_to teams_path
    else
  		render "edit"
  	end
  end

end
