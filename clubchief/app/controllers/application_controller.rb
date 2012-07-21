class ApplicationController < ActionController::Base


  before_filter :session_expiry, :except => [:login, :logout]
  before_filter :update_activity_time, :except => [:login, :logout]

  helper :all # include all helpers, all the time

  helper_method :logged_in?, :get_current_user, :get_current_user_id, :get_user_notifications,
                :get_user_latest_notification, :get_user_events, :get_user_latest_event, :is_admin?,
                 :is_club_admin?, :valid_email_dns?, :base_url, :initialize_session_time

  private

  def session_expiry
    if !session[:expires_at]
      return	
    end
    @time_left = (session[:expires_at] - Time.now).to_i
    unless @time_left > 0
      reset_session
      flash[:error] = "Session has timed out."
      redirect_to login_path
    end
  end

  def update_activity_time
    if !session[:expires_at]
      return
    end
    session[:expires_at] = TIME_OUT.minutes.from_now
  end

  #def set_base_url
  #  if !session[:base_url]
  #    session[:base_url] ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
  #  end
  #end

  def authorize
    	unless logged_in?
      		flash[:error] = "Please Log in to access this area"
      		redirect_to login_path
      		false
    	end
  end

  protected
  def logged_in?
	    email = session[:email]
    	password = session[:password]

    	if User.authenticate(email, password)
     		true
    	else
        false
    	end
  end

  def get_current_user
    	email = session[:email]
    	password = session[:password]
    	return User.authenticate(email, password)
  end

  def get_current_user_id
    	return get_current_user.id
  end

  def get_user_notifications
     @notifications = []
     if teams = get_current_user.teams
       teams.each do |team|
          team.notifications.each do |note|
            @notifications.push(note)
          end
       end
     end
     return @notifications
  end

  def get_user_latest_notification
    @notifications = []
    @notifications = get_user_notifications
    last = 0; n = nil
    @notifications.each do |note|
      n = note
      if note.created_at > n.created_at
          n = note
      end
    end
    return n
  end

  def get_user_events
     @events = []
     if teams = get_current_user.teams
       teams.each do |team|
          team.events.each do |event|
            @events.push(event)
          end
       end
     end
     return @events
  end

  def get_user_latest_event
    @events = []
    @events = get_user_events
    last = 0; e = nil
    @events.each do |event|
      e = event
      if event.created_at > e.created_at
          e = note
      end
    end
    return e
  end

  def is_admin?(user)
    	if user != nil
      		if user.memberships.where(:admin => true).any?
         		return true
      		end
    	end
    	return false
  end
  
    def is_a_team_admin?
    	if user = get_current_user
      		if user.memberships.where(:admin => true).any?
         		return true
         	else
         		flash[:error] = "You need to be a club or team admin to access this area"
         		redirect_to home_path
      		end
    	else
    		flash[:error] = "Please Log in to access this area"
    		redirect_to login_path
    	end
  end
  
 def is_team_admin?(team)
    	if user = get_current_user
      		teams = user.memberships.where(:admin => true).collect{ |membership| membership.team }
         	teams.each do |admin_team |
         		if admin_team.id == team.id
         			return true
         		elsif admin_team.club_team
         			if team.club_id == admin_team.club_id   
         				return true
         			end      			
         		end        		
         	end
    	end
    	return false
  end

  def is_club_admin?(club)
    if user = get_current_user
      memberships = user.memberships.where(:admin => true)
      memberships.each do |membership|
        if membership.team.club_team
      	  if club.id == membership.team.club_id
      	  	return true
      	  end
        end
      end
    end
    return false  
  end 

  def is_a_club_admin?
    if user = get_current_user
      		memberships = user.memberships.where(:admin => true)
          memberships.each do |membership|
            if membership.team.club_team
         		  return true
            end
      		end
    		flash[:error] = "You need to be a club admin to access this area"
    else
      flash[:error] = "Please Log in to access this area"
    end
    redirect_to home_path
    return false
  end

    def is_a_admin?
    	if user != get_current_user
      		if user.memberships.where(:admin => true).any?
         		return true
      		end
    	end
    	return false
  end

  #Validate email via DNS
  def valid_email_dns?(email)
    if email.include?('@') and email.include?('.')
        domain = email.match(/\@(.+)/)[1]
        Resolv::DNS.open do |dns|
            @mx = dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
        end
        @mx.size > 0 ? true : false
    else
      return false
    end
  end

  def base_url
    #if session[:base_url]
    #  return session[:base_url]
    #else
      return BASE_URL
    #end
  end

  def initialize_session_time
    session[:expires_at] = TIME_OUT.minutes.from_now
  end
  
  def create_password
    o =  [('a'..'z'),('A'..'Z'),('0'..'9')].map{|i| i.to_a}.flatten
    new_password = (0..6).map{ o[rand(o.length)]  }.join
    return new_password
  end

  def help
  end
  
    def get_admin_clubs
  	if user = get_current_user
  		memberships = user.memberships.where(:admin => true)
  		clubs = []
  		memberships.each do |membership|
            if membership.team.club_team
         		  clubs << membership.team.club
            end
        end
        return clubs
  	end
  	return false
  end

end
