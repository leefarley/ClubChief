class SessionsController < ApplicationController

  def new

  end

  def create
      deny = false #deny user login
      email = params[:email]
      session[:email] = email.downcase
      session[:password] = (params[:password])
      if (logged_in?)

          #Check account verification
          user = get_current_user
          if !user.verified?
            if session[:verify_user] == true
               user.password = session[:password]
               if user.verify_user!
                  session[:verify_user] = false
                  flash[:success] = "Your account has been verified!"
               else
                  if user.errors.any?
                    str = ""
                    user.errors.full_messages.each do |msg|
                      str += msg + " | "
                    end
                    flash[:alert] = str
                  end
                  session[:email] = params[:email]
                  session[:password] = (params[:password])
                  session[:verify_user] = false
                  deny = true
                  redirect_to login_path
               end
            else
              session[:email] = ""
              session[:password] = ""
              flash[:alert] = "This account has not been verified. You must open the email sent to you and verify your account before logging on."
              deny = true
              redirect_to login_path
            end
          end

        else
          flash[:alert] = "Incorrect login details"
          deny = true
          render 'new'
        end

      if !deny
        initialize_session_time

        #Check if they need to change their password (change_password field)
        if user.change_password?
          flash[:alert] = "You may change your password before continuing."
          redirect_to :controller => 'users', :action => 'edit_password', :id => user.id
        else
          redirect_to home_path
        end

      end
  end

  def destroy
    reset_session
    flash[:success] = "Successfully logged out"
    redirect_to home_path
  end

  def show
  end

end
