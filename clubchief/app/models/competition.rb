class Competition < ActiveRecord::Base
	
  has_many    :competition_applications
  belongs_to  :club
  has_many    :teams

  validates :club_id, :presence => true
  
  validates :name, :presence => true,
                   :length => {:within => 5..40,
                               :too_short=> 'competition name needs to be more descriptive. Minimum 5 characters',
                               :too_long => 'competition name cannot exceed 40 characters'}
                               

  validates :deadline, 
  					:date => { :after => Time.now , :message => "Your competition needs to have a deadline in the future." } ,
  					:presence => true
 # need to write a validator to make sure that the deadline in in the future                           

end



# == Schema Information
#
# Table name: competitions
#
#  id                  :integer         not null, primary key
#  name                :string(255)     not null
#  deadline            :datetime        not null
#  club_id             :integer         not null
#  competition_finshed :boolean         default(FALSE)
#  description         :text
#  created_at          :datetime
#  updated_at          :datetime
#

