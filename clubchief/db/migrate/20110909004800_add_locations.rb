class AddLocations < ActiveRecord::Migration
  def self.up
    TownCity.create(
    	:name => "Cromwell"
    )
        TownCity.create(
    	:name => "Gore"
    )
        TownCity.create(
    	:name => "Alexandra"
    )
        TownCity.create(
    	:name => "Oamaru"
    )
        TownCity.create(
    	:name => "Timaru"
    )
        TownCity.create(
    	:name => "Queenstown"
    )
        TownCity.create(
    	:name => "Christchurch"
    )
        TownCity.create(
    	:name => "Invercargill"
    )
        TownCity.create(
    	:name => "Winton"
    )
        TownCity.create(
    	:name => "Ashburton"
    )
        TownCity.create(
    	:name => "Balclutha"
    )
        TownCity.create(
    	:name => "Wanaka"
    )
        TownCity.create(
    	:name => "Mosgiel"
    )
        TownCity.create(
    	:name => "Milton"
    )
        TownCity.create(
    	:name => "Matarua"
    )
        TownCity.create(
    	:name => "Ranfurly"
    )
        TownCity.create(
    	:name => "Arrowtown"
    )
        TownCity.create(
    	:name => "Te Anua"
    )
        TownCity.create(
    	:name => "Otautau"
    )
        TownCity.create(
    	:name => "Lumsden"
    )
        TownCity.create(
    	:name => "Riverton"
    )
        TownCity.create(
    	:name => "Bluff"
    )


  end

  def self.down
  end
end
