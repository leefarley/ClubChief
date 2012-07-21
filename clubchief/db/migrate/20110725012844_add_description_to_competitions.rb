class AddDescriptionToCompetitions < ActiveRecord::Migration
  def self.up
  	change_table :competitions do |t|
  		
  	end
  end

  def self.down
  	remove_column :competitions, :description
  end
end
