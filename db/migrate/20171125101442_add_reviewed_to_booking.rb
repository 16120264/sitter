class AddReviewedToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :reviewed, :boolean, default: 0
  end
end
