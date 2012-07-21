class CompetitionsController < ApplicationController
  
  before_filter :authorize
  before_filter :is_a_club_admin?, :only => :create


  def index
      user = get_current_user
      clubs = user.teams.collect{|team| team.club}.uniq
      @competitions = []
      clubs.each do |club|
        club.competitions.each do |competition|
          #has the competiton passed the application deadline.
          if competition.deadline > Time.now
            #the following is a check for if the user already has any applications to this competition
            if (competition.competition_applications & user.competition_applications).empty?
              #add the competition to the list of appliable competitions
              @competitions << competition
            end
          end
        end
      end
  end

  def apply
    user = get_current_user
    competition = Competition.find(params[:competition_id])
    # need to check that the user has not already applied for this competition 
    if (competition.competition_applications & user.competition_applications).empty?
      if user.competition_applications.create(:competition_id => competition.id)
        flash[:success] = "Successfully applied for "+competition.name
      end
    else
      flash[:alert] = "You have already applied for "+competition.name
    end
    redirect_to :action => 'index'
  end

  def create
  	@competition = Competition.new
  	render "admin_competitions/new"
  end

  def show
  end

end
