class Checkin < ActiveRecord::Base
  attr_accessible :foursquare_id, :user_id, :venue_id

  belongs_to :user, :class_name => 'FoursquareUser'
  has_many   :foods

  def reply
    user.client.create_checkin_reply(
      foursquare_id,
      text: reply_message,
      url: url
    )
  end

  def reply_message
    foods_at_venue = user && user.foods_at(venue_id).order(:id)
    if foods_at_venue.blank?
      "Something smells good! What did you order?"
    else
      last = foods_at_venue.last
      <<-EOS.squish
        You've eaten #{foods_at_venue.count} things here. Last time, you
        thought the #{last.description} was #{last.rating_as_emotion}.
      EOS
    end
  end

  def url
    Rails.application.routes.url_helpers.new_checkin_food_url(self,
      :host => HOST
    )
  end

  after_commit :reply, :on => :create
end
