class Checkin < ActiveRecord::Base
  attr_accessible :foursquare_id, :user_id, :venue_id

  belongs_to :user, :class_name => 'FoursquareUser'
  has_many   :foods

  def reply
    user.client.create_checkin_reply(foursquare_id, text: "hello world!")
  end

  after_commit :reply, :on => :create
end
