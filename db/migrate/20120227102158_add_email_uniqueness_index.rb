class AddEmailUniquenessIndex < ActiveRecord::Migration
  def up
    add_index :admins, :email, :unique => true
  end

  def down
    remove_index :admins, :email
  end
end
