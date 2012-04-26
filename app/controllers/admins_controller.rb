class AdminsController < ApplicationController
  # before_filter :is_campaign?
  before_filter :authenticate, :only  => [:index, :edit, :show, :update, :destroy]
  before_filter :correct_admin, :only => [:edit, :show, :update]
  before_filter :superauthenticate, :only => :destroy
  
  def generate
    # render :layout => "ticket"
    
    @campaign = Admin.find_by_subdomain!(request.subdomain)
    @title = @campaign.pagetitle
    @choices = @campaign.prizes.where("inventory != 0")
    @overall = 1 # @choices.count + 1
    @weight = @choices.map(&:weight)
    @winner = @weight.inject(:+)
    @weight << @overall - @winner
    @loser = Prize.new(  :name => "loss",
                         :winmessage => "#{@campaign.losemessage}",
                         :redeemmessage => "losing ticket",
                         :inventory => 1,
                         :image => "loss",
                         :expiry => @campaign.limit )
    @choices << @loser
    @scratchoff = @choices.weighted_random(@weight)
    # cookies[:redeemed] = "not_redeemed"
  end
  
  def marketing
    @title ="Welcome to mobilezen Scratchoff!"
  end
  
  def index
    if current_admin.super?
      @admins = Admin.all
      @title = "mobilezen Scratchoff | All Campaigns"
    else
      redirect_to dashboard_path(params[:id])
    end
  end
  
  def dashboard
    render :layout => "application"
    @prizes = current_admin.prizes
    @title = "Scratchoff Dashboard - #{current_admin.subdomain}"
  end
  
  def show
    render :layout => "application"
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
    render :layout => "application"
    @admin = Admin.find(params[:id])
    @title = "Account Update"
  end
  
  def update
    @admin = Admin.find(params[:id])
    if @admin.update_attributes(params[:admin])
      redirect_to @admin, :flash => { :success => "Profile updated" }
    else
      @title = "Update Account"
      render 'edit'
    end
  end
  
  def destroy
    @admin.destroy
    redirect_to admins_path, :flash => { :flash => "Successfully deleted..." }
  end
  
  private
    
    def correct_admin
      @admin = Admin.find(params[:id])
      redirect_to(signin_path) unless current_admin?(@admin)
    end
    
    def superauthenticate
      @admin = Admin.find(params[:id])
      redirect_to(signin_path) if !current_admin.super? || current_admin?(@admin)
    end
  
end