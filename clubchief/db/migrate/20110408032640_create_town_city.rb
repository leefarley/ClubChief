 class CreateTownCity < ActiveRecord::Migration
  def self.up
    create_table :town_cities do |t|
      t.string 		:name

      t.timestamps
    end
    
    TownCity.create(
    	:name => "Dunedin"
    )
    
  end


  def self.down
    drop_table :town_city
  end
end
