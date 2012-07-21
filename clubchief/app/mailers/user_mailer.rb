class UserMailer < ActionMailer::Base
  helper :application
  default :from => "ClubChief<em.clubchief@gmail.com>"

  def registration_confirmation(user)
    #if !valid_email_dns?(user.email) #check the email has a valid DNS
    #  return false
    #end
    @user = user
    user.set_verification_token
    mail(:to => "#{user.first_name} <#{user.email}>", :subject => "Registered to Club Chief")
  end
  
  def admin_signup(user, club)
    @user = user
    @club = club
    mail(:to => "#{user.first_name} <#{user.email}>", :subject => "Signed up to #{club.name}" ,  :from => "#{club.name}<em.clubchief@gmail.com>")
  end

  def send_notification(creator, to, note)
    #if !valid_email_dns?(to.email) #check the email has a valid DNS
    #  return false
    #end
    @user = creator
    @notification = note
    mail(:to => "#{to.first_name} <#{to.email}>", :subject => "Notification Received", :from => "#{@notification.team.name} <em.clubchief@gmail.com>")
  end

  def send_event(creator, to, event)
    #if !valid_email_dns?(to.email) #check the email has a valid DNS
    #  return false
    #end
    @user = creator
    @event = event
    @attendee = Attendee.find_by_user_id_and_event_id(to.id, event.id)
    mail(:to => "#{to.first_name} <#{to.email}>", :subject => "Event Notice", :from => "#{@event.team.name} <em.clubchief@gmail.com>")
  end

  def send_reset_password(user, password)
    #if !valid_email_dns?(user.email) #check the email has a valid DNS
    #  return false
    #end
    @user = user
    @password = password
    mail(:to => "#{user.first_name} <#{user.email}>", :subject => "Reset Password")
  end

  def register_club(club)
    @club = club
    mail(:to => "ClubChief<em.clubchief@gmail.com>", :subject => "#{@club.name} has been registered")
  end

end
