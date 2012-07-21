class AddEncryptedIdToAttendees < ActiveRecord::Migration
  def self.up
    add_column :attendees, :salt, :string
    add_column :attendees, :encrypted_id, :string

    Attendee.all.each { |attendee|
      attendee.secure_salt
      attendee.save
    }
  end

  def self.down
    remove_column :attendees, :encrypted_id
    remove_column :attendees, :salt
  end
end
