require 'spec_helper'

describe Attendee do
  pending "add some examples to (or delete) #{__FILE__}"
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

