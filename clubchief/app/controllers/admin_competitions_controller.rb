class AdminCompetitionsController < ApplicationController
  before_filter  :is_a_club_admin?


  def index
    user = get_current_user
    memberships = user.memberships.where(:admin => true)
    @competitions = []
    memberships.each do |membership|
      if membership.team.club_team 
        membership.team.club.competitions.each do |competition|
            @competitions << competition
        end
      end
    end
  end

  def show
    if Competition.exists?(params[:competition_id])
      @competition = Competition.find(params[:competition_id])
      if @competition.competition_finshed == false
        if @competition.deadline < Time.now 
          @teams = @competition.teams
          @applications = @competition.competition_applications
        else
          flash[:alert] = @competition.name+" has not met it's deadline yet"
          redirect_to :action => 'index'      
        end
      else
        flash[:alert] = @competition.name+" has finshed and can no longer be sorted"
        redirect_to :action => 'index'  
      end
    else
      flash[:alert] = "Sorry that competition does not exist"
      redirect_to :action => 'index' 
    end

  end

  def new
    @competition = Competition.new
  end

  def create
  	@competition = Competition.new(params[:competition])
  	if @competition.save
      flash[:success] = "Successfully created the competition: " + @competition.name
  		redirect_to admin_competitions_path
    else
      flash[:alert] = "Unable to create competition"
    	render "new"
    end
  end
  
  def edit
  	@competition = Competition.find(params[:id])
  end
  
  def update
  	@competition =  Competition.find(params[:id])
  	if @competition.update_attributes(params[:competition])
      flash[:success] = "Successfully updated the competition: " + @competition.name
  		redirect_to  admin_competitions_path
    else
      flash[:alert] = "Unable to update competition"
  		render "edit"
  	end
  end
  
  def destroy
  	if Competition.exists?(params[:id])
  		competition = Competition.find(params[:id])
  		if competition.competition_applications.count == 0
  			if Competition.delete(competition)
  				flash[:success] = "Successfully removed " + competition.name
  			else
  				flash[:alert] = "Unable to remove " + competition.name
  			end
  		else
  			flash[:alert] = "Unable to remove " + competition.name + " because it has applicants"
  		end
  	else
  		flash[:alert] = "This competition does not exist."
  	end
  	redirect_to :back
  end

  def add_team
     @competition =  Competition.find(params[:competition_id])
  end
  
    def create_team
    team = Team.new(params[:team])
    if !team.name.empty?
      if team.save
        flash[:success] = "You have successfully created team '"+team.name+"'"
      else
        flash[:alert] = "Your new team was not able to be saved"
      end
  else
    flash[:alert] = "A new team needs to have a name"
  end
    redirect_to manage_competition_path(params[:team][:competition_id])
  end
  
end
