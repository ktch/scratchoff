require 'spec_helper'

describe Prize do
  
  before(:each) do
    @admin = Factory(:admin)
    @attr = { :name => "Basketball", 
              :winmessage => "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed quam ante, feugiat eu mattis pretium, posuere non leo. In egestas dui ut purus volutpat faucibus. Curabitur blandit rutrum ante, ut varius libero interdum non. Curabitur lobortis, justo sit amet vestibulum viverra, erat felis vestibulum tellus, elementum pharetra lectus magna sed arcu. Ut a adipiscing lacus. Class aptent taciti sociosqu ad.",
              :redeemmessage => "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed quam ante, feugiat eu mattis pretium, posuere non leo. In egestas dui ut purus volutpat faucibus. Curabitur blandit rutrum ante, ut varius libero interdum non. Curabitur lobortis, justo sit amet vestibulum viverra, erat felis vestibulum tellus, elementum pharetra lectus magna sed arcu. Ut a adipiscing lacus. Class aptent taciti sociosqu ad.",
              :odds => "500:1000",
              :inventory => 10,
              :image => "img/prize.png" }
  end
  
  it "should create a new prize with valid attributes" do
    @admin.prizes.create!(@attr)
  end
  
  describe "admin associations" do
    
    before(:each) do
      @prize = @admin.prizes.create(@attr)
    end
    
    it "should have an admin key" do
      @prize.should respond_to(:admin)
    end
    
    it "should have the correct associated admin" do
      @prize.admin_id.should == @admin.id
      @prize.admin.should == @admin
    end
  end
  
  describe "validations" do
    
    before(:each) do
      @prize = @admin.prizes.create(@attr)
    end
    
    it "should have an admin_id" do
      Prize.new(@attr).should_not be_valid
    end
    
    it "should have calculated its own weight" do
      @prize.weight.should_not be_nil
    end
    
    it "should require nonblank name" do
      @admin.prizes.build(:name => "     ").should_not be_valid
    end
    
  end
  
end
# == Schema Information
#
# Table name: prizes
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  winmessage    :text
#  redeemmessage :text
#  odds          :string(255)
#  inventory     :integer
#  image         :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  admin_id      :integer
#  weight        :float
#  suremessage   :string(255)
#  expiry        :integer
#

