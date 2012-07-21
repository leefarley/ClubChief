require 'spec_helper'

describe User do

  before(:each) do
    @attr = { :first_name => 'lee',
              :last_name => 'farley',
              :password => 'password',
              :password_confirmation => 'password',
              :email => 'lee@em.com'}
  end
  it 'should  have a valid user' do
    user = User.create(@attr)
    user.should be_valid
  end

  it 'should require a name' do
    user = User.new(@attr.merge(:first_name => ''))
    user.should_not be_valid
  end

  it 'should require an email address' do
    user = User.new(@attr.merge(:email => ''))
    user.should_not be_valid
  end

  it 'should reject first names that are too long' do
    long_name = "a" * 21
    user = User.new(@attr.merge(:first_name => long_name))
    user.should_not be_valid
  end

  it 'should reject last names that are too long' do
    long_name = "a" * 21
    user = User.new(@attr.merge(:last_name => long_name))
    user.should_not be_valid
  end

  it 'should have a valid email' do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it 'should reject invalid email addresses' do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end


  it 'should not save duplicate email addresses' do
    user1 = User.create(@attr)
    user2 = User.create(@attr)
    user1.save
    user2.save
    user1.should be_valid
    user2.should_not be_valid
  end

  it 'should not have emails that are too long' do
    email = 'a' * 60 + '@email.com'
    user = User.create(@attr.merge(:email => email))
    user.should_not be_valid
  end


  describe "passwords" do

    before(:each) do
      @user = User.new(@attr)
    end

    it 'should have a password attribute' do
      @user.should respond_to(:password)
    end

    it 'should have a password conformation' do
      @user.should respond_to(:password_confirmation)
    end

  end


  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
          should_not be_valid
    end

    it 'should require a matching password confirmation' do
      User.new(@attr.merge(:password_confirmation => "invalid")).
          should_not be_valid
    end

    it 'should reject passwords that is too short' do
      short_password = "a" * 5
      hash = @attr.merge(:password => short_password,
                         :password_confirmation => short_password)
      User.new(hash).should_not be_valid
    end

    it 'should reject passwords that is too long' do
      short_password = "a" * 31
      hash = @attr.merge(:password => short_password,
                         :password_confirmation => short_password)
      User.new(hash).should_not be_valid
    end
  end

  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

    it "should have a salt" do

    end

    describe "has_password? method" do
      it "should exist" do
        @user.should respond_to(:has_password?)
      end

      it "should return true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "Should return false if the password do not match" do
        @user.has_password?(@attr["invalid"]).should be_false
      end
    end
    describe "authenticate method" do
      it "should exist" do
        User.should respond_to(:authenticate)
      end

      it "should return nil on email/password mismatch" do
        User.authenticate(@attr[:email], "wrongpass").should be_nil
      end

      it "should return nil for an email with no user" do
        User.authenticate("bar@foo.com", @attr[:password]).should be_nil
      end

      it "should return the user on email/password match" do
        User.authenticate(@attr[:email], @attr[:password]).should == @user
      end
    end

  end

end


# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  first_name         :string(255)     not null
#  last_name          :string(255)     not null
#  email              :string(255)     not null
#  encrypted_password :string(255)     not null
#  salt               :string(255)     not null
#  student_id         :string(255)
#  phone              :string(255)
#  address            :string(255)
#  verified           :boolean         default(FALSE)
#  change_password    :boolean         default(FALSE)
#  perishable_token   :string(255)     default("")
#  created_at         :datetime
#  updated_at         :datetime
#

