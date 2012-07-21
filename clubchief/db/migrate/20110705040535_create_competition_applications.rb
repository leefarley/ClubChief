class CreateCompetitionApplications < ActiveRecord::Migration
  def self.up
    create_table :competition_applications do |t|
      t.integer :user_id , :null => false
      t.integer :competition_id , :null => false
      t.boolean  :assiged_to_team, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :competition_applications
  end
end
