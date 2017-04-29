class AddPriceToBookings2 < ActiveRecord::Migration
  def change
    add_column :bookings, :add_on, :string
  end
end
