class AdminsController < ActionController::Base
  
  def dashboard
    @title = "Scratchoff Dashboard"
    @admin = Admin.find(1)
  end
  
  def show
    @admin = Admin.find(params[:id])
  end
  
end