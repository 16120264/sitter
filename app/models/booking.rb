class Booking < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  has_many :ratings
  #validates :id, uniqueness: { scope: [:timeslot, :date, :zone_id] }
  validates_uniqueness_of :timeslot, scope: [:date, :zone_id ]
  validate :booking_date_cannot_be_in_the_past

  def booking_date_cannot_be_in_the_past
    if date.present? && date < Date.today
      errors.add(:date, "Don't waste your money booking dates in the past - move on with your life !")
    end
  end    
end

