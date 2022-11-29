class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name, null: false
      t.integer :floor_number, null: false
      t.integer :capacity, null: false

      t.timestamps
    end
  end
end
