class AddTeams < ActiveRecord::Migration
  def self.up

Team.create(:name =>'OU Mens Basketball',
            :club_id=>'1',
            :club_team=> true)
Team.create(:name =>'Comets A',
            :club_id=>'1',
            :club_team=>false,
            :competition_id => 1)
Team.create(:name=>'Blaze B',
            :club_id =>'1',
            :club_team=>false,
            :competition_id => 1)
Team.create(:name=>'Comets C',
            :club_id =>'1',
            :club_team =>false,
            :competition_id => 1)
Team.create(:name=>'Jaffas C',
            :club_id=>'1',
            :club_team=>false,
            :competition_id => 1)


  end

  def self.down
  end
end
