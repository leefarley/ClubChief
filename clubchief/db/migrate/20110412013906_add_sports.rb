class AddSports < ActiveRecord::Migration
  def self.up

    Sport.create(:sport_name => 'Ice Hockey')
    Sport.create(:sport_name => 'Hockey')
    Sport.create(:sport_name => 'BasketBall')
    Sport.create(:sport_name => 'Squash')
    Sport.create(:sport_name => 'Chess')
    Sport.create(:sport_name => 'Tennis')
    Sport.create(:sport_name => 'Rugby')
    Sport.create(:sport_name => 'Soccer')
    Sport.create(:sport_name => 'Bowls')
    Sport.create(:sport_name => 'Baseball')
    Sport.create(:sport_name => 'Softball')
    Sport.create(:sport_name => 'BMX')
    Sport.create(:sport_name => 'Grass Carting')
    Sport.create(:sport_name => 'Go Carting')
    Sport.create(:sport_name => 'Golf')
  end

  def self.down
  end
end
