require 'spec_helper'

describe AdminsController do
  render_views
  
  describe "GET 'show'" do
    
    before(:each) do
      @admin = Factory(:admin)
    end
    
    it "should be successful" do
      get :show, :id => @admin
      response.should be_success
    end
    
    it "should find the right admin" do
      get :show, :id => @admin
      assigns(:admin).should == @admin
    end
    
    it "should have the right title" do
      get :show, :id => @admin
      response.should have_selector('title', :content => @admin.name)
    end
    
    it "should have the right name" do
      get :show, :id => @admin
      response.should have_selector('h1', :content => @admin.name)
    end
    
    it "should have a logo" do
      get :show, :id => @admin
      response.should have_selector('header>img', :class => "logo")
    end
    
  end
  
  describe "GET 'new'" do
    
    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector('title', :content => "Sign up")
    end
  end
end