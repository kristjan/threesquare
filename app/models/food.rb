class Food < ActiveRecord::Base
  attr_accessible :checkin_id, :description, :rating, :venue_id

  has_one :checkin

  validates_presence_of :description
  validates_numericality_of :rating, :in => -1..1
end
