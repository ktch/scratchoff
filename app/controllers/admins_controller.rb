class AdminsController < ActionController::Base
  
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
  
  def edit
    @admin = Admin.find(params[:id])
  end
  
  def update
    @admin = Admin.find(params[:id])

    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        format.html { redirect_to @admin, notice: 'Prize was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
end