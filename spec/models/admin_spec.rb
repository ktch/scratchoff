require 'spec_helper'

describe Admin do
  
  before(:each) do
    @attr = { :name => "Example User", :email => "user@example.com", :password => "foobar", :password_confirmation => "foobar" }
  end
  
  it "should create a new instance given a valid attribute" do
    Admin.create!(@attr)
  end
  
  it "should require a name" do
    no_name_user = Admin.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require an email" do
    no_name_user = Admin.new(@attr.merge(:email => ""))
    no_name_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = Admin.new(@attr.merge(:name => long_name ))
    long_name_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.be]
    addresses.each do |address|
      valid_email_user = Admin.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com, user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = Admin.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    Admin.create!(@attr)
    user_with_duplicate_email = Admin.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    Admin.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = Admin.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  describe "passwords" do
    
    before(:each) do
      @admin = Admin.new(@attr)
    end
    
    it "should have a password attribute" do
      @admin.should respond_to(:password)
    end
    
    it "should have a password confirmation attribute" do
      @admin.should respond_to(:password_confirmation)
    end
    
  end
  
  describe "password validations" do
    
    it "should require a password" do
      Admin.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end
    
    it "should require a matching password confirmation" do
      Admin.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      Admin.new(hash).should_not be_valid
    end
    
    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      Admin.new(hash).should_not be_valid
    end
    
  end
  
  describe "password encryption" do
      
    before(:each) do
      @admin = Admin.create!(@attr)
    end
      
    it "should have an encrypted password attribute" do
      @admin.should respond_to(:encrypted_password)
    end
  end
  
end
# == Schema Information
#
# Table name: admins
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  logo               :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  encrypted_password :string(255)
#

