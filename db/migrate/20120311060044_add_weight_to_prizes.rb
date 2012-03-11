class AddWeightToPrizes < ActiveRecord::Migration
  def change
    add_column :prizes, :weight, :float

  end
end
