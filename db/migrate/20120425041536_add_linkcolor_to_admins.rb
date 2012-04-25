class AddLinkcolorToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :linkcolor, :string

  end
end
