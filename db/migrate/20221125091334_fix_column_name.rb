class FixColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :rooms, :room_name, :name

    change_table :bookings do |t|
      t.rename :booking_description, :description
      t.rename :booking_duration, :duration
    end
  end
end
