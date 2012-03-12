class AddThankyouToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :thankyou, :text

  end
end
