class AdminsController < ActionController::Base
  
  def dashboard
    @title = "Scratchoff Dashboard"
  end
  
  def show
    @admin = Admin.find(params[:id])
  end
  
end