class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.text :booking_description, null: false
      t.datetime :start_date_time, null: false
      t.time :booking_duration, null: false
      t.references :user, :room

      t.timestamps
    end
  end
end
