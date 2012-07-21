class UserVerificationsController < ApplicationController

  before_filter :load_user_using_url_token

  def index

  end

  def show
    if !@user.verified?
        session[:verify_user] = true
        flash[:success] = "Please log in to finish verifying your account (" + @user.email + ")"
        redirect_to login_path
    else
      flash[:error] = "This account has already been verified."
      redirect_to root_url
    end
  end

  private

  def load_user_using_url_token
    @user = []
    if URI.parse(request.url).query != "" and URI.parse(request.url).query != nil
      @token = CGI.parse(URI.parse(request.url).query)
      token = @token[""].to_s.split("-").first.gsub(/[^0-9A-Za-z]/,'') or ''
      id = @token[""].to_s.split("-").second.gsub(/[^0-9A-Za-z]/,'') or ''
      if Rails.env.development? then flash[:alert] = "id: " + id + " token: " + token end
      if User.exists?(id)
        @user = User.find(id)
      else
        @user = nil
      end
      if @user != nil #Make sure the user exists
          if token == @user.perishable_token #Check the perishable token is legal and matches
             return
          else
            flash[:error] = "Illegal attempt to verify this account."
            redirect_to root_url
          end
      else
        flash[:error] = "Unable to find your account, invalid token."
        redirect_to root_url
      end
    else
      flash[:error] = "Invalid URL."
      redirect_to root_url
    end
  end
end
