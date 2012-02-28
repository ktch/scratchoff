require 'spec_helper'

describe "Admins" do
  
  describe "signup" do
  
    describe "failure" do
      
      it "should not make a new admin" do
        lambda do
          visit new_admin_path
          fill_in "Name",                     :with => ""
          fill_in "Email",                    :with => ""
          fill_in "Password",                 :with => ""
          fill_in "Confirm Password",         :with => ""
          click_button
          response.should render_template('admins/new')
          response.should have_selector('div#error_explanation')
        end.should_not change(Admin, :count)
      end
    end
    
    describe "success" do
      
      it "should make a new admin" do
        lambda do
          visit new_admin_path
          fill_in "Name",                     :with => "Zach Phillips"
          fill_in "Email",                    :with => "zhphillips@gmail.com"
          fill_in "Password",                 :with => "foobar"
          fill_in "Confirm Password",         :with => "foobar"
          click_button
          response.should have_selector('div.flash.success', :content => "Welcome")
          response.should render_template('admins/show')
        end.should change(Admin, :count).by(1)
      end
      
    end
    
  end
end
