class AddExpiryToPrizes < ActiveRecord::Migration
  def change
    add_column :prizes, :expiry, :integer

  end
end
