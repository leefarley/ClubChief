class AdminUsersController < ApplicationController
  before_filter  :is_a_club_admin?



  def index # needs a bug fix, only pulls the users first club
  	user = get_current_user
  	@club = Club.find(params[:club_id])
		team = @club.teams.where(:club_team => true).first
		@members = []
		@admins = []
		#iterate over all the users and separate out admins
		team.memberships.each do |membership|
			if (membership.admin)
				@admins << membership.user
			else
				@members << membership.user
			end 
    end
  end
  
  def assign_admin
 	if Club.exists?(params[:club_id])
  		club = Club.find(params[:club_id])
  		if User.exists?(params[:user_id])
  			user = User.find(params[:user_id])
  			membership = club.all_member_team.memberships.where(:user_id => user.id).first
  			if membership.update_attributes(:admin => true)
  				flash[:success] = "#{user.full_name} is now a admin of #{club.name}"
  			else
  				flash[:alert] = "#{user.full_name} could not be given permissions for #{club.name}"
  			end
  		else
  			flash[:error] = "This user does not exist"
  		end
  	else
  		flash[:error] = "This club does not exist"
  	end
  	redirect_to :action => :index, :club_id => club.id
  end
  
  def new
  	user = get_current_user
    @user = User.new
    memberships = user.memberships.where(:admin => true)
    @clubs = []
    memberships.each do |membership|
      if membership.team.club_team 
        @clubs << membership.club
      end
    end
  end

  def create
    @user = User.new(params[:user])
    @user.email.downcase!
    @club = Club.find(params[:post][:club_id])
    if valid_email_dns?(@user.email)
    	@user.password = create_password
    	@user.password_confirmation = @user.password
    	if User.find_by_email(@user.email)
    	 	team = @club.all_member_team
    	   	user = User.find_by_email(@user.email)
    	   	if !Membership.find_by_user_id_and_team_id(user.id, team.id)
    	   		team.memberships.create(:user_id => user.id )
    	   		flash[:success] = @user.full_name.to_s + " has been added to " + @club.name.to_s
    	   		#foreach event in the team create a attendee row in the database for the new member
                team.add_user_to_current_events(user)
    	   	else
    	   		flash[:alert] = @user.full_name.to_s+" is already a member of this club"
    	   	end
    	elsif @user.save
    	    UserMailer.admin_signup(@user,@club).deliver
   	    	flash[:success] = @user.full_name.to_s + " has been created and signed up to " + @club.name.to_s
   	    	team = @club.all_member_team
    	   	user = User.find_by_email(@user.email)
    	   	team.memberships.create(:user_id => user.id )
    	 else
    	    	@user.password = ""
    	    	@user.password_confirmation = ""
    	 end
    else
    	@user.password = ""
  	@user.password_confirmation = ""
	flash[:alert] = "Please enter a valid email address."
    end
    redirect_to :back
  end

end
