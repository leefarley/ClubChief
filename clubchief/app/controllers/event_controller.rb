class EventController < ApplicationController

  before_filter :authorize , :only => :show
  before_filter :is_a_team_admin?  , :except => [:attending, :not_attending,:show, :extern_change_attend_status]

  
  def show
     @event = Event.find(params[:id])
     @user = get_current_user
     @attendees = @event.attendees
  end

  def new
    @event = Event.new
    @user = get_current_user
    @teams =  @user.get_manageable_teams
  end

  def create
    @event = Event.new(params[:event])
    @event.user_id = get_current_user_id
    if user = get_current_user
      if @event.save
        #Create a thread for sending the mail
          #mailer = Thread.new{
            @event.team.users.each do |to|
                @event.attendees.create(:user_id => to.id)
		          if @event.user_id != to.id
		              UserMailer.send_event(user, to, @event).deliver
		          end
            end
          #}
          #mailer.abort_on_exception = true #Make sure the thread doesn't remain after a crash

          flash[:success] = "Event created!"
          redirect_to calendar_path
      else
          @teams = get_current_user.get_manageable_teams
          render 'new'
      end
    end
  end


  def extern_change_attend_status
    @event = Event.find(params[:event_id])
    attendee = Attendee.find_by_encrypted_id(params[:attendee_id]) # HASHED attendee id in the url
    if attendee != nil and @event != nil
      if Rails.env.development? then flash[:alert] = "user id: " + attendee.id.to_s + " event id: " + @event.id.to_s end
      if attendee.set_attend_status(true)
        flash[:success] = "You have changed your attending status for event: " + @event.name
        redirect_to event_path(@event.id)
      end
    else
      flash[:alert] = "Attendee not found."
      redirect_to home_path
    end
  end

  def not_attending
  	
    @event = Event.find(params[:event_id])
    attendee = @event.attendees.find(params[:attendee_id])
    if (is_team_admin?(@event.team)  or get_current_user_id == attendee.user_id)
    	if attendee.set_attend_status(false)
        flash[:success] = attendee.user.full_name.to_s() + " is not attending " + @event.name
      end
    else
    	flash[:alert] = "You do not have permissions"
    end
    redirect_to :back
  end

  def attending
    @event = Event.find(params[:event_id])
    attendee = @event.attendees.find(params[:attendee_id])
    if (is_team_admin?(@event.team)  or get_current_user_id == attendee.user_id)
    	if attendee.set_attend_status(true)
        flash[:success] = attendee.user.full_name.to_s() + " is attending " + @event.name
      end
    else
    	flash[:alert] = "You do not have permissions"
    end
    redirect_to :back
  end

  def edit
    if Event.exists?(params[:id])
    	@event = Event.find(params[:id])
    else
    	flash[:alert] = "This event does not exist."
    end
  end
  
  def update
  	if Event.exists?(params[:id])
  		@event = Event.find(params[:id])
  		if @event.update_attributes(params[:event])
  			flash[:success] = "Successfully updated "+ @event.name
  			redirect_to event_path(@event)
  		else
  			flash[:alert] = "Unable to update "+ @event.name
  			redirect_to :back
  		end
  	else
    	flash[:alert] = "This event does not exist."
    	redirect_to :back
    end
  end
  
  def destroy
  	if Event.exists?(params[:id])
  		@event = Event.find(params[:id])
  		if Event.delete(@event)
  			flash[:success] = "Successfully removed " + @event.name
  			# we need to delete all of the attendees at this point.
  			redirect_to calendar_path
  		else
  			flash[:alert] = "Unable to remove removed " + @event.name
  			redirect_to event_path(@event)
  		end
  	else
  		flash[:alert] = "This event does not exist."
  		redirect_to :back
  	end
  end

end
