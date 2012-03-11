require "spec_helper"

describe PrizesController do
  render_views
  
  before(:each) do
    @sacrifice = Factory(:prize, :id => 1)
  end
  
  describe "access" do
    it "should deny access to create" do
      post :create
      response.should redirect_to(signin_path)
    end
    
    it "should deny access to destroy" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end  
  end
  
  describe "POST 'create'" do
    before(:each) do
      @admin = test_sign_in(Factory(:admin))
    end
    
    describe "failure" do
      
      before(:each) do
        @attr = { :name => "", :odds => "500:1000" }
      end
      
      it "should not create a new prize" do
        lambda do
          post :create, :prize => @attr
        end.should_not change(Prize, :count)
      end
      
      it "should re-render the home page" do
        post :create, :prize => @attr
        response.should render_template('sessions/new')
      end
    end
    
    describe "success" do
      
      before(:each) do
        @goodattr = { :name => "wawa",
                  :winmessage => "wawawawawawawawawaw",
                  :redeemmessage => "weeeweeeeeeeeee",
                  :odds => "500:1000",
                  :inventory => 30,
                  :image => "img/test.png" } 
      end
      
      it "should create a new prize" do
        lambda do
          post :create, :prize => @goodattr
        end.should change(Prize, :count).by(1)
      end
      
      
    end
    
  end
  
end