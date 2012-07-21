class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.integer :user_id, :null => false
      t.integer :team_id, :null => false
      t.boolean :admin , :default => false

      t.timestamps
    end
    add_index :memberships, [:user_id,:team_id], :unique => true
    
    Membership.create(:user_id => '1',
                      :team_id => '1',
                      :admin => true)
    Membership.create(:user_id => '2',
                      :team_id => '1',
                      :admin => true)
    Membership.create(:user_id => '3',
                      :team_id => '1',
                      :admin => true)
  end

  def self.down
    drop_table :memberships
  end
end
