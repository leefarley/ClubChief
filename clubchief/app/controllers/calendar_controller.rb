class CalendarController < ApplicationController

  before_filter :authorize

  def index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)
	
	user = get_current_user
    @teams = user.teams

    if club_teams = @teams.where(:club_team => true)
   	club_teams.each do |club_team|
   			if club_team.memberships.find_by_user_id(user.id)
      			@teams  += Team.find_all_by_club_id(club_team.club_id)
      			@teams = @teams.uniq
      		end
    	end
    end

    @event_strips = Event.where(:team_id => @teams).event_strips_for_month(@shown_month)
  end
  
end
