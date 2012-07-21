module ApplicationHelper
  
  def currentuser
    User.authenticate(session[:email],session[:password])
  end

  def logged_in?
    if (@loggedIn == true)
      return true
    else
      
	    email = session[:email]
    	password = session[:password]

    	if User.authenticate(email, password)
        @loggedIn = true
     		true
      else
        @loggedIn = false
        false
    	end

    end
  end

  def avatar_url(email)
    if (email != :null)
	    gravatar_id = Digest::MD5.hexdigest(email.downcase)
	    return "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d="
    else
      return "#"
    end
  end

    def is_a_club_admin?
    if user = get_current_user
      memberships = user.memberships.where(:admin => true)
      memberships.each do |membership|
        if membership.team.club_team
          return true
        end
      end
    end
    return false
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

  def base_url
    #if session[:base_url]
    #  return session[:base_url]
    #else
      return BASE_URL
    #end
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

end
