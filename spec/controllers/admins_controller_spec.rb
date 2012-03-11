require 'spec_helper'

describe AdminsController do
  render_views
  
  describe "GET 'index'" do
    
    describe "for non-superadmins" do
      
      before(:each) do
        @admin = Factory(:admin)
        test_sign_in(@admin)
      end
      
      it "should deny access" do
        get :index
        response.should redirect_to(dashboard_path)
      end
    end
    
    describe "for superadmins" do
      
      before(:each) do
        @superadmin = Factory(:admin, :super => true)
        test_sign_in(@superadmin)
      end
      
      it "should allow access" do
        get :index
        response.should be_success
      end
    end
    
  end
  
  describe "GET 'dashboard'" do
    
    before(:each) do
      @admin = Factory(:admin)
      test_sign_in(@admin)
    end
    
    it "should show the admin's prizes" do
      pr1 = Factory(:prize, :admin => @admin)
      pr2 = Factory(:prize, :admin => @admin)
      get :dashboard, :id => @admin
      response.should have_selector('div.prizelisting', :content => pr1.name)
    end
    
  end
  
  describe "GET 'show'" do
    
    before(:each) do
      @admin = Factory(:admin)
      test_sign_in(@admin)
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
      response.should have_selector('h1', :content => @admin.subdomain)
    end
    
    it "should have a logo" do
      get :show, :id => @admin
      response.should have_selector('header>img', :class => "logo")
    end
    
  end
  
  describe "GET 'new'" do
    
    before(:each) do
      @admin = Factory(:admin)
      test_sign_in(@admin)
    end
    
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
        @attr = { :subdomain => "", :name => "", :email => "", :password => "", :password_confirmation => ""}
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
        @attr = { :subdomain => "new", :name => "New User", :email => "user@example.com", :password => "foobar", :password_confirmation => "foobar"}
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
  
  describe "authentication of edit/update actions" do
    
    before(:each) do
      @admin = Factory(:admin, :email => "user4@example.net",
                               :subdomain => "mygod")
    end
    
    describe "for non-signed-in admins" do
    
      it "should deny access to 'edit'" do
        get :edit, :id => @admin
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    
      it "should deny access to 'update'" do
        put :update, :id => @admin, :admin => {}
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for signed-in admins" do
      
      before(:each) do
        wrong_admin = Factory(:admin, :email => "wrong5@example.net",
                                      :subdomain => "mygoodness")
        test_sign_in(wrong_admin)
      end
      
      it "should require matching users for 'edit'" do
        get :edit, :id => @admin
        response.should redirect_to(signin_path)
      end
      
      it "should require matching users for 'update'" do
        put :update, :id => @admin, :admin => {}
        response.should redirect_to(signin_path)
      end
      
    end
  end
  
  describe "DELETE 'destroy'" do
    
    
    describe "as a non-signed in admin" do
      
      it "should deny access" do
        delete :destroy, :id => @admin
        response.should redirect_to(signin_path)
      end
    end
    
    describe "as a non-super admin" do
      
      before(:each) do
        @admin = Factory(:admin)
      end
      
      it "should protect the action" do
        test_sign_in(@admin)
        delete :destroy, :id => @admin
        response.should redirect_to(signin_path)
      end
    end
    
    
    
  end
  
end