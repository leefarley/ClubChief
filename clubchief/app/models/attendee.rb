# == Schema Information
#
# Table name: attendees
#
#  id             :integer         not null, primary key
#  user_id        :integer
#  event_id       :integer
#  encrypted_id   :varchar
#  attending      :boolean         default(TRUE)
#  created_at     :datetime
#  updated_at     :datetime
#
class Attendee < ActiveRecord::Base

  attr_accessible   :user_id

  belongs_to :user
  belongs_to :event

  before_save :encrypt_id

  def set_attend_status(v)
    if !!v == v #Check if the value is a boolean
      #Check if v is the same as the current value
      #If so make it the opposite value
      if self.attending == v
        if v == false
          self.attending = true
        else
          self.attending = false
        end
      else
        self.attending = v
      end
      #Save change - return accordingly
      if self.save
        return true
      end
    end
    return false
  end

  def encrypted_id_match?(submitted_id)
    self.encrypted_id == encrypt(submitted_id)
  end

  def secure_salt
    self.salt = make_salt
  end

  private
  def encrypt_id
    self.salt = make_salt if self.new_record?
    if(self.encrypted_id == nil or self.encrypted_id.empty?) #avoid changing the hash each save
      self.encrypted_id = encrypt(self.id)
    end
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{id}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

end

# == Schema Information
#
# Table name: attendees
#
#  id           :integer         not null, primary key
#  user_id      :integer
#  event_id     :integer
#  attending    :boolean         default(TRUE)
#  created_at   :datetime
#  updated_at   :datetime
#  salt         :string(255)
#  encrypted_id :string(255)
#

