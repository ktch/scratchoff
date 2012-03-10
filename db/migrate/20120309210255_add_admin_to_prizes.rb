class AddAdminToPrizes < ActiveRecord::Migration
  def change
    add_column :prizes, :admin_id, :integer
  end
end
