class UsersController < ApplicationController

  before_filter :authorize, :except => [:new, :create, :show_recover, :send_recover]

  def show
    @user = User.find(params[:id])
  end


  def new
    @user = User.new
  end


  def create
    @user = User.new(params[:user])
    @user.email.downcase!
    if valid_email_dns?(@user.email)
      if User.find_by_email(@user.email)

        flash[:alert] = @user.email.to_s() + " has already been registered."
        render 'new'
         else
      if @user.save
        mailer = Thread.new{ UserMailer.registration_confirmation(@user).deliver } #New thread to send the mail
        mailer.abort_on_exception = true #Make sure the thread doesn't remain after a crash
        flash[:success] = "Thanks for signing up, we've delivered an email to you with instructions on how to complete your registration!"
        redirect_to home_path
      else
        @user.password = ""
        @user.password_confirmation = ""
        render 'new'
      end

      end
    else
       @user.password = ""
       @user.password_confirmation = ""
       flash[:alert] = "Please enter a valid email address."
       render 'new'
    end
  end


  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    @user.email.downcase!
    @user.password = session[:password]
    @user.password_confirmation = @user.password
    respond_to do |format|
      if @user.update_attributes(params[:user])
        session[:email] = @user.email
        session[:password] = @user.password
        flash[:success] = "Profile was successfully updated"
        format.html { redirect_to user_path }
        format.xml  { head :ok }
      else
        flash[:alert] = "Profile was unable to be updated"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end


  def change_password
    @user = User.find(params[:id])
    if @user != nil
      if session[:change_password] != true
        @user.password = session[:password]
        session[:change_password] = true
        redirect_to :action => 'edit_password', :id => @user.id
      else
        redirect_to :action => 'edit_password', :id => @user.id
      end
    else
      redirect_to home_path
    end
  end


  def edit_password
    #Make sure the user exists and has the required change_password field (true)
    if user = get_current_user and (user.change_password? or session[:change_password] == true)
      @user = user
    else
      redirect_to home_path
    end
  end


  def update_password
    update_params = params[:user]
    @user = User.find(update_params[:user_id])
    current_password =  update_params[:current_password]
    if current_password != nil and current_password != ""
      if current_password == session[:password]
        @user.password = session[:password]
        @user.password_confirmation = @user.password
        respond_to do |format|
          if @user.update_attributes(update_params)
            session[:email] = @user.email
            session[:password] = @user.password
            @user.set_change_password(false)
            flash[:success] = 'Password has been successfully changed.'
            format.html { redirect_to home_path }
            format.xml  { head :ok }
          else
            flash[:alert] = 'Password was unable to be changed.'
            format.html { render :action => "edit_password", :id => @user.id }
            format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
          end
        end
      else
        flash[:alert] = "Current password is incorrect."
        redirect_to :action => 'edit_password', :id => @user.id
      end
    else
      flash[:alert] = "Please enter your current password."
      redirect_to :action => 'edit_password', :id => @user.id
    end
  end


  def show_recover
  end


  def send_recover
    @user = User.find_by_email(params[:email])
    if @user != nil
      password = @user.reset_password
      if password != nil and password != ""
        mailer = Thread.new{ UserMailer.send_reset_password(@user, password).deliver }
        mailer.abort_on_exception = true
        @user.set_change_password(true)
      else
        flash[:alert] = "Something has gone wrong while sending the recovery email, please try again. Make sure the email you provided is valid."
      end
      if flash[:alert] == "" or flash[:alert] == nil
        flash[:success] = "An email with your new password has been sent to " + params[:email] + ". If you cannot find the email, please make sure you check 'junk' and 'spam' sections."
        redirect_to home_path
      else
        redirect_to recover_path
      end
    else
      flash[:alert] = "The email you have entered does not exist in our database."
      redirect_to recover_path
    end
  end

  def userhelp
  end

end
