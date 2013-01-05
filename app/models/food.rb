class Food < ActiveRecord::Base
  attr_accessible :checkin_id, :description, :rating, :venue_id
end
