class CreateCompetitions < ActiveRecord::Migration
  def self.up
    create_table :competitions do |t|
      t.string   :name , :null => false
      t.datetime :deadline , :null => false
      t.integer  :club_id, :null => false
      t.boolean  :competition_finshed, :default => false
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :competitions
  end
end
