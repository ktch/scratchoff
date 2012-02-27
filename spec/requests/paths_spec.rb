require 'spec_helper'

describe "Paths" do
  it "should have a homepage at /" do
    get '/'
    response.should have_selector('title', :content => 'BPampm Scratchoff')
  end
  
  it "should have an admin dashboard at /dashboard" do
    get '/dashboard'
    response.should have_selector('title', :content => 'Scratchoff Dashboard')
  end
  
end
