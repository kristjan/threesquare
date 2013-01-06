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
    if foods.empty?
      "Something smells good! What did you order?"
    else
      last = foods.last
      <<-EOS.squish
        You've eaten #{foods.count} things here.
        Last time, you thought the <strong>#{last.description}</strong>
        was <strong>#{last.rating_as_emotion}</strong>.
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
