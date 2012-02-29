class AdminsController < ApplicationController
  before_filter :superauthenticate, :only => [:index]
  before_filter :authenticate, :only  => [:edit, :update]
  before_filter :correct_admin, :only => [:edit, :update]
  
  def index
    @admins = Admin.all
    @title = "mobilezen Scratchoff | All Campaigns"
  end
  
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
    @title = "Account Update"
  end
  
  def update
    @admin = Admin.find(params[:id])
    if @admin.update_attributes(params[:admin])
      redirect_to @user, :flash => { :success => "Profile updated" }
    else
      @title = "Update Account"
      render 'edit'
    end
  end
  
  private
    
    def superauthenticate
      go_to_dashboard unless signed_in?
    end
    
    def authenticate
      flash[:notice] = "You must sign in to access this page."
      deny_access unless signed_in?
    end
    
    def correct_admin
      @admin = Admin.find(params[:id])
      redirect_to(root_path) unless current_admin?(@admin)
    end
  
end