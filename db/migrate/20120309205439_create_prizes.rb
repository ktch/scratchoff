class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.string :name
      t.text :winmessage
      t.text :redeemmessage
      t.string :odds
      t.integer :inventory
      t.string :image

      t.timestamps
    end
  end
end
