class AddLosemessageToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :losemessage, :text

  end
end
