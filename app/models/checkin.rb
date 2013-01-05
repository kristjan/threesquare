class Checkin < ActiveRecord::Base
  attr_accessible :foursquare_id, :user_id, :venue_id

  belongs_to :user, :class_name => 'FoursquareUser'
  has_many   :foods

  def reply
    user.client.create_checkin_reply(
      foursquare_id,
      text: "Something smells good! What did you order?",
      url: url
    )
  end

  def url
    Rails.application.routes.url_helpers.new_checkin_food_url(self,
      :host => HOST
    )
  end

  after_commit :reply, :on => :create
end
