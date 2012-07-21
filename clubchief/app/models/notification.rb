# == Schema Information
#
# Table name: notifications
#
#  id         :integer         not null, primary key
#  message    :string(255)     not null
#  team_id    :integer
#  user_id    :integer
#  send_email :boolean         default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class Notification < ActiveRecord::Base
	@@per_page = 1
#  only the message is allowed to be changed once the notification has been created
  attr_accessible :message, :team_id, :user_id, :send_email

#  a notification can only belong to a single club
  belongs_to :team

#  one notification can only be posted by one person
  belongs_to :user

# the message has to exist and have between 10 and 256 characters
  validates :message, :presence => true,
                      :length => {:within => 5..256}

end



