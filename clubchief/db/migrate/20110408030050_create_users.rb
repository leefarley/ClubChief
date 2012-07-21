class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :email, :null => false
      t.string :encrypted_password, :null => false
      t.string :salt, :null => false
      t.string :student_id
      t.string :phone
      t.string :address
      t.boolean :verified, :default => false
      t.boolean :change_password, :default => false
      t.string  :perishable_token, :default => ""

      t.timestamps
    end
    
    add_index :users, [:email], :unique => true
    
    User.create(:first_name => 'BJ',
                :last_name => 'Smid',
                :email => 'bj@em.com',
                :password => 'password',
                :password_confirmation => 'password')

    User.create(:first_name => 'Lee',
                :last_name => 'Farley',
                :email => 'lee@em.com',
                :password => 'password',
                :password_confirmation => 'password')

    User.create(:first_name => 'Ben',
                :last_name => 'Dol',
                :email => 'ben@em.com',
                :password => 'password',
                :password_confirmation => 'password')
end



  def self.down
    drop_table :users
  end
end
