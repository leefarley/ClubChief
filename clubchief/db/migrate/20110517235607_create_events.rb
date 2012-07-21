class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string   :name, :null => false
      t.text     :message, :null => false
      t.datetime :start_at, :null => false
      t.datetime :end_at, :null => false
      t.integer  :team_id, :null => false
      t.integer :user_id,  :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
