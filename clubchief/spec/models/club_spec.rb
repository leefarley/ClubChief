require 'spec_helper'

describe Club do
  before(:each) do
    @attr = {:name => 'foobar',
             :description => 'foo bar is a sport club',
             :sport_id => 1}
  end

  it 'should be successful' do
    club = Club.create(@attr.merge(:sport_id => 1))
    club.should be_valid
  end


  it 'should not have a name that is too long' do
    long_name = 'a'* 41
    club = Club.create(@attr.merge(:name => long_name))
    club.should_not be_valid
  end

  it 'should not have a non numeric sport_id' do
    club = Club.create(@attr.merge(:sport_id => 'a'))
    club.should_not be_valid
  end

  it 'should not have a negative sport_id' do
    club = Club.create(@attr.merge(:sport_id => -1))
    club.should_not be_valid
  end

  describe 'null value' do
    it 'should not have a null name' do
      club = Club.create(@attr.merge(:name => ''))
      club.should_not be_valid
    end
    it 'should not have a null description' do
      club = Club.create(@attr.merge(:description => ''))
      club.should_not be_valid
    end
    it 'should not have a null sport_id' do
      club = Club.create(@attr.merge(:sport_id => ''))
      club.should_not be_valid
    end
  end
end


# == Schema Information
#
# Table name: clubs
#
#  id             :integer         not null, primary key
#  name           :string(255)     not null
#  description    :text
#  sport_id       :integer
#  street_address :text
#  suburb         :text
#  town_city_id   :integer
#  created_at     :datetime
#  updated_at     :datetime
#

