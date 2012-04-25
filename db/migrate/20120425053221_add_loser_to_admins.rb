class AddLoserToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :loser, :string

  end
end
