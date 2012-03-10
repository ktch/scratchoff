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
    
    it "should set the encrypted password attribute" do
      @admin.encrypted_password.should_not be_blank
    end
    
    it "should have a salt" do
      @admin.should respond_to(:salt)
    end
    
    describe "has_password? method" do
      
      it "should exist" do
        @admin.should respond_to(:has_password?)
      end
      
      it "should return true if the passwords match" do
        @admin.has_password?(@attr[:password]).should be_true
      end
      
      it "should return false if the passwords don't match" do
        @admin.has_password?("invalid").should be_false        
      end
    end
    
    describe "authenticate method" do
      
      it "should exist" do
        Admin.should respond_to(:authenticate)
      end
      
      it "should return nil on email/password mismatch" do
        Admin.authenticate(@attr[:email], "wrongpass").should be_nil
      end
      
      it "should return nil for an email address with no admin associated" do
        Admin.authenticate("bar@none.com", @attr[:password]).should be_nil
      end
      
      it "should return the admin on email/password match" do
        Admin.authenticate(@attr[:email], @attr[:password]).should == @admin
      end
    end
    
  end
  
  describe "superadmin attributes" do
    
    before(:each) do
      @admin = Admin.create!(@attr)
    end
    
    it "should respond to superadmin" do
      @admin.should respond_to(:super)
    end
    
    it "should not be a superadmin by default" do
      @admin.should_not be_super
    end
      
    it "should be convertible to a superadmin" do
      @admin.toggle!(:super)
      @admin.should be_super
    end
    
  end
  
  describe "prize associations" do
    
    before(:each) do
      @admin = Admin.create(@attr)
      @pr1 = Factory(:prize, :admin => @admin, :created_at => 1.day.ago)
      @pr2 = Factory(:prize, :admin => @admin, :created_at => 1.hour.ago)
    end
    
    it "should have a prizes attribute" do
      @admin.should respond_to(:prizes)
    end
    
    it "should have the right prizes in the right order" do
      @admin.prizes.should == [@pr2, @pr1]
    end
    
    it "should destroy associated prizes" do
      @admin.destroy
      [@pr1, @pr2].each do |prize|
        Prize.find_by_id(prize.id).should be_nil
      end
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
#  salt               :string(255)
#  super              :boolean         default(FALSE)
#

