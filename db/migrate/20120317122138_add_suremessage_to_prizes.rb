class AddSuremessageToPrizes < ActiveRecord::Migration
  def change
    add_column :prizes, :suremessage, :string

  end
end
