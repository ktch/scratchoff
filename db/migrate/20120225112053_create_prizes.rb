class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.string :name
      t.float :odds
      t.integer :amount
      t.string :image

      t.timestamps
    end
  end
end
