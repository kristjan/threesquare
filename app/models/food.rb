class Food < ActiveRecord::Base
  attr_accessible :checkin_id, :description, :rating, :venue_id

  belongs_to :checkin

  validates_presence_of :description
  validates_numericality_of :rating, :in => -1..1

  EMOTIONS = {
    -1 => :bad,
     0 => :fine,
     1 => :great
  }

  def rating_as_emotion
    EMOTIONS[rating]
  end

  def smiley(yellow=false)
    "smiley_#{rating_as_emotion}#{yellow ? '_yellow' : ''}.png"
  end
end
