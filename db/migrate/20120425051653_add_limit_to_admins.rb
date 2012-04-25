class AddLimitToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :limit, :integer

  end
end
