class AdminsController < ApplicationController
  # before_filter :is_campaign?
  before_filter :authenticate, :only  => [:index, :edit, :update, :destroy, :dashboard]
  before_filter :correct_admin, :only => [:edit, :update, :dashboard]
  before_filter :superauthenticate, :only => :destroy
  
  def generate
    @title = "BPampm Scratchoff"
    @campaign = Admin.find_by_subdomain!(request.subdomain)
    @choices = @campaign.prizes.where("inventory != 0")
    @overall = @choices.count + 1
    @weight = @choices.map(&:weight)
    @winner = @weight.inject(:+)
    @weight << @overall - @winner
    @loser = Prize.new(  :name => "loss",
                         :winmessage => "#{@campaign.losemessage}",
                         :redeemmessage => "losing ticket",
                         :inventory => 1,
                         :image => "img/loss.png" )
    @choices << @loser
    @scratchoff = @choices.weighted_random(@weight)
    @scratchoff.inventory -= 1 unless @scratchoff.inventory.zero?
    @scratchoff.save
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
    @admin = current_admin
    @prizes = @admin.prizes
    @title = "Scratchoff Dashboard - #{@admin.subdomain}"
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