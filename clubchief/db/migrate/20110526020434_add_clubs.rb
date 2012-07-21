class AddClubs < ActiveRecord::Migration
  def self.up
    
      Club.create(:name =>'OU Mens Basketball',
            :description => 'The Otago University Mens Basketball Club',
            :sport_id => '3',
            :town_city_id => 1)
  end

  def self.down
  end
end
