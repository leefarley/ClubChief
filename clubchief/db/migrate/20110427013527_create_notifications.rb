class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.string  :message, :null => false
      t.integer :team_id
      t.integer :user_id
      t.boolean :send_email , :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :notifications
  end
end
