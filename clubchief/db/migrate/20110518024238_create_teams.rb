class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string   :name, :null => false
      t.integer  :club_id, :null => false
      t.boolean  :club_team, :default => false
      t.integer  :competition_id
      t.integer  :max_players # this is a nullable field that users do not need to use

      t.timestamps
    end
  end


  def self.down
    drop_table :teams
  end
end
