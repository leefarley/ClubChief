class CompetitionApplicationsController < ApplicationController
  before_filter :authorize

  def index
      user = get_current_user
      @pending_applications = user.competition_applications.where(:assiged_to_team => false)
  end

end
