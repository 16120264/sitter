class Rating < ActiveRecord::Base
  belongs_to :booking
  validates_inclusion_of :stars, in: 1..5
end
