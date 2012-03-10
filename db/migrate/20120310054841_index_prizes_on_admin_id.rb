class IndexPrizesOnAdminId < ActiveRecord::Migration
  def up
    add_column :prizes, :admin_id, :integer
    add_index :prizes, :admin_id
  end

  def down
    remove_index :prizes, :admin_id
  end
end
