class AdminsController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update] 
  
  def dashboard
    @title = "Scratchoff Dashboard"
    @admin = Admin.find(1)
  end
  
  def show
    @admin = Admin.find(params[:id])
    @title = @admin.name
  end
  
  def new
    @admin = Admin.new
    @title = "Sign up"
  end
  
  def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      sign_in @admin
      redirect_to @admin, :flash => { :success => "Welcome to mobilezen Scratchoff!"}
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def edit
    @admin = Admin.find(params[:id])
  end
  
  def update
    @admin = Admin.find(params[:id])
    if @admin.update_attributes(params[:admin])
      # It worked
    else
      @title = "Update Account"
      render 'edit'
    end
  end
  
  private
    
    def authenticate
      flash[:notice] = "You must sign in to access this page."
      redirect_to signin_path unless signed_in?
    end
  
end