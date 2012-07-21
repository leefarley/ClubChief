 class CreateClubs < ActiveRecord::Migration
  def self.up
    create_table :clubs do |t|
      t.string 		:name, :null => false
      t.text 		:description
      t.integer 	:sport_id
	    t.text 		:street_address
	    t.text 		:suburb
	    t.integer		:town_city_id
      t.timestamps
    end
  end


  def self.down
    drop_table :clubs
  end
end
