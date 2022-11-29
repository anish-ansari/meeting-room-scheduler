class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.text :description, null: false
      t.datetime :start_date_time, null: false
      t.datetime :end_date_time, null: false
      t.references :user, :room

      t.timestamps
    end
  end
end
