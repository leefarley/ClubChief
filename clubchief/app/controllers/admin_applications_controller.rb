class AdminApplicationsController < ApplicationController
		before_filter :is_a_club_admin?

		#this method allows a admin to choose a new applicant for a competition of his club
		def new
			if Competition.exists?(params[:competition_id]) 
				@competition = Competition.find(params[:competition_id])
				users = @competition.club.users
				applcations = @competition.competition_applications.collect{|application| application.user_id }
				@users = []
				users.each do |user|
					unless applcations.include?(user.id)
						@users << user
					end
				end
			end
		end
		
		#this method is responsible for createing a application for the admins selected member
		def create
			if Competition.exists?(params[:competition_id])
				if User.exists?(params[:user_id])
					user = User.find(params[:user_id])
					competition = Competition.find(params[:competition_id])
					if user.competition_applications.create(:competition_id => competition.id)
						flash[:success] = "#{user.full_name} has successfully added to #{competition.name}"
					else
						flash[:alert] = "#{user.full_name} could not be added to #{competition.name}"
					end
				else
					flash[:alert] = "User does not exist"
				end
			else
				flash[:alert] = "Competition does not exist"
			end
			redirect_to :back
		end
end
