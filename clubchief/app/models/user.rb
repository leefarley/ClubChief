class User < ActiveRecord::Base

  attr_accessor     :password,
                    :current_password
  
  attr_accessible   :first_name,
                    :last_name,
                    :email,
                    :password,
                    :password_confirmation,
                    :current_password,
                    :student_id,
                    :phone,
                    :address,
                    :perishable_token,
                    :verified


  has_many :memberships

  has_many :teams, :through => :memberships

# this allows the user to be associated with a notification so we can see what user posts what notifications
  has_many :notifications

  has_many :competition_applications
  
  has_many :attendees

  validates_length_of :first_name, :last_name, :within => 1..20 ,:too_long=>"your name needs to be less than 40 characters", :too_short=>"Your name must contain characters"

  #validates_numericality_of :phone, :only_integer => true, :message => "phone number can only be a number value."
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,     :presence => true,
                        :format => {:with => email_regex},
                        :uniqueness => true,
                        :length => {:maximum => 60}

  validates :password,  :presence => true,
                        :confirmation => true,
                        :length => {:within => 6..100 }

 before_save :encrypt_password

  def clubs
    return self.teams.collect{|team|team.club}
  end

  def get_teams
    return self.teams.where(:club_team => false)
  end

  def get_manageable_teams
    teams =  self.memberships.where(:admin => true).collect { |membership| membership.team  }
    teams.each do |team|
      if team.club_team == true
        teams = teams | team.club.teams
      end
    end
    return teams
  end

  def is_member_of?(club_id)
    if (teams.find_by_club_id(club_id))
        return true
    else
        return false
    end
  end

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def User.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def full_name
    first_name+" "+last_name
  end

  def set_verification_token
    o =  [('a'..'z'),('A'..'Z'),('0'..'9')].map{|i| i.to_a}.flatten
    string  =  (0..40).map{ o[rand(o.length)]  }.join
    self.perishable_token = string
    self.save
  end

  def set_change_password(v)
    if !!v == v #Check if the value is a boolean
      self.change_password = v
      if self.save
        return true
      end
    end
    return false
  end

  def verify_user!
    self.verified = true
    self.perishable_token = ""
    if self.save
      return true
    end
    return false
  end

  def verified?
    if self.perishable_token != nil and self.perishable_token != "" and !self.verified
      return false
    end
    return true
  end

  #Sets password to a random string
  #Returns unencrypted password value
  def reset_password
    o =  [('a'..'z'),('A'..'Z'),('0'..'9')].map{|i| i.to_a}.flatten
    new_password = (0..6).map{ o[rand(o.length)]  }.join
    self.password = new_password
    if self.save
        return new_password
    else
      return nil
    end
  end

 private
  def encrypt_password
    self.salt = make_salt if self.new_record?
    self.encrypted_password = encrypt(self.password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

end

# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  first_name         :string(255)     not null
#  last_name          :string(255)     not null
#  email              :string(255)     not null
#  encrypted_password :string(255)     not null
#  salt               :string(255)     not null
#  student_id         :string(255)
#  phone              :string(255)
#  address            :string(255)
#  verified           :boolean         default(FALSE)
#  change_password    :boolean         default(FALSE)
#  perishable_token   :string(255)     default("")
#  created_at         :datetime
#  updated_at         :datetime
#

