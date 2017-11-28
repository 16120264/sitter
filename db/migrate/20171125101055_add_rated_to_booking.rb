class AddRatedToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :rated, :boolean, default: 0
  end
end
