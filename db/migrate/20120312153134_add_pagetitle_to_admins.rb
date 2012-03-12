class AddPagetitleToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :pagetitle, :string

  end
end
