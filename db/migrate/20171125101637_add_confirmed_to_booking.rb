class AddConfirmedToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :confirmed, :boolean, default: 0
  end
end
