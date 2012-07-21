require 'will_paginate/array'
class NotificationsController < ApplicationController

   before_filter :authorize,  :only => :show
   before_filter :is_a_team_admin? , :except => [:show]


 def show
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

      @notifications = Notification.where(:team_id => @teams).paginate( :per_page => 10, :page => params[:page])

  end


  def new
      @notification = Notification.new
      @user = get_current_user      
      @teams = @user.get_manageable_teams
  end

  def create
    @notification = Notification.new(params[:notification])
    @notification.user_id = get_current_user_id
    send_email = @notification.send_email?
    if user = get_current_user
      if @notification.team_id != nil
        if @notification.save

          #Send mail to users
          if send_email == true
              #Create a thread for sending the mail
              #mutex = Mutex.new
              #mailer = Thread.new{
               @notification.team.users.each do |to|
                  if to.id != user.id
                    #mutex.synchronize do #Lock
                      UserMailer.send_notification(user, to, @notification).deliver
                    #end
                  end
               end
              #}
              #mailer.abort_on_exception = true #Make sure the thread doesn't remain after a crash
          end
          flash[:success] = "Successfully created notification."
          redirect_to notifications_path
        else
          @teams = get_current_user.teams.all
          render 'new'
        end
      else
         @teams = get_current_user.teams.all
         flash[:alert] = "Please select a team before continuing."
         render 'new'
      end
    else
      flash[:alert] = "You must be logged in to post a notification."
      redirect_to notifications_path
    end
  end

  def edit
  	if Notification.exists?(params[:id])
  		@notification = Notification.find(params[:id])
  		@teams = get_current_user.memberships.where(:admin => true).collect { |membership| membership.team  }
    else
    	redirect_to notifications_path
    end
  end
  
  
  def update
  	if Notification.exists?(params[:notification][:id])
  		@notification = Notification.find(params[:id])
  		if @notification.update_attributes(params[:notification])
  			flash[:success] = "Successfully updated notification"
  			  			#Send mail to users
          	if @notification.send_email == true
              #Create a thread for sending the mail
              #mutex = Mutex.new
              #mailer = Thread.new{
               @notification.team.users.each do |to|
                  if to.id != get_current_user_id
                    #mutex.synchronize do #Lock
                      UserMailer.send_notification(user, to, @notification).deliver
                    #end
                  end
               end
              #}
              #mailer.abort_on_exception = true #Make sure the thread doesn't remain after a crash
          end
  			redirect_to notifications_path
  		else
  			flash[:alert] = "Unable to update notification"
  			redirect_to :back
  		end
  	else
    	flash[:alert] = "This event does not exist."
    	redirect_to :back
    end
  end
  
  def destroy
  	if Notification.exists?(params[:id])
  		@notification = Notification.find(params[:id])
  		if Notification.delete(@notification)
  			flash[:success] = "Successfully removed notification"
  			redirect_to notifications_path
  		else
  			flash[:alert] = "Unable to remove notification"
  			redirect_to notification_path(@notification)
  		end
  	else
  		flash[:alert] = "Notification does not exist."
  		redirect_to :back
  	end
  end
  
end
