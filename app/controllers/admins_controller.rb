class AdminsController < ApplicationController
  
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

    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        format.html { redirect_to @admin, notice: 'Your account was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
end