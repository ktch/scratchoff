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
  
  describe "POST 'create'" do
    
    describe "failure" do
      
      before(:each) do
        @attr = { :name => "", :email => "", :password => "", :password_confirmation => ""}
      end
      
      it "should have the right title" do
        post :create, :admin => @attr
        response.should have_selector('title', :content => "Sign up" )
      end  
        
      it "should render the 'new' page" do
        post :create, :admin => @attr
        response.should render_template('new')
      end
      
      it "should not create an admin" do
        lambda do
          post :create, :admin => @attr
        end.should_not change(Admin, :count)
      end
    end
    
    describe "success" do
      
      before(:each) do
        @attr = { :name => "New User", :email => "user@example.com", :password => "foobar", :password_confirmation => "foobar"}
      end
      
      it "should create an admin" do
        lambda do
          post :create, :admin => @attr
        end.should change(Admin, :count).by(1)
      end
      
      it "should redirect to the admin dashboard page" do
        post :create, :admin => @attr
        response.should redirect_to(admin_path(assigns(:admin)))
      end
      
      it "should have a welcome message" do
        post :create, :admin => @attr
        flash[:success].should =~ /welcome to mobilezen Scratchoff!/i
      end
      
    end
    
  end
  
end