class AddBackgroundToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :background, :string
                
    add_column :admins, :bgcolor, :string
  
    add_column :admins, :fontcolor, :string

  end
end
