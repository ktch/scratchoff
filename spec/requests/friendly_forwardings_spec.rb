require 'spec_helper'

describe "FriendlyForwardings" do
  
  it "should forward to the originally requested page after signin" do
    admin = Factory(:admin)
    visit edit_admin_path(admin)
    fill_in :email,   :with => admin.email
    fill_in :password,:with => admin.password
    click_button
    response.should render_template('admins/edit')
    visit signout_path
    visit signin_path
    fill_in :email,   :with => admin.email
    fill_in :password,:with => admin.password
    click_button
    response.should render_template('admins/show')
  end
  
end
