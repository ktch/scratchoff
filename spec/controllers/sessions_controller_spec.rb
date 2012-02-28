require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector('title', :content => "Sign in")
    end
  end
  
  describe "POST 'create'" do
    
    describe "failure" do
      
      before(:each) do
        @attr = { :email => "", :password => "" }
      end
      
      it "should re-render the new page" do
        post :create, :session => @attr
      end
    end
    
    describe "success" do
      before(:each) do
        @admin = Factory(:admin)
        @attr = { :email => @admin.email, :password => @admin.password }
      end
      
      it "should sign the admin in" do
        post :create, :session => @attr
        controller.current_admin.should == @admin
        controller.should be_signed_in
      end
      
      it "should redirect" do
        post :create, :session => @attr
        response.should redirect_to(admin_path(@admin))
      end
      
    end
    
  end

end
