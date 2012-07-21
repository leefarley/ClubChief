class AddCompetitions < ActiveRecord::Migration
  def self.up
    Competition.create!(
      :name => "Otago University Basketball 2011",
      :club_id => 1,
      :deadline =>  Time.now + 1.day
    )

  end

  def self.down
  end
end
