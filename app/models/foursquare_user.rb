class FoursquareUser < ActiveRecord::Base
  has_many :checkins, :foreign_key => :user_id
  has_many :foods, :through => :checkins

  def name
    client.user_name
  end

  def client
    @client ||= FoursquareClient.new(access_token)
  end

  def check_in(foursquare_checkin)
     checkins.create(
      :venue_id      => foursquare_checkin["venue"]["id"],
      :foursquare_id => foursquare_checkin["id"]
    )
  end

  class << self
    def find_or_create_by_access_token(access_token)
      client = FoursquareClient.new(access_token)

      unless user = self.find_by_foursquare_id(client.user_id)
        user = self.new
        user.foursquare_id = client.user_id
        user.access_token = client.access_token
        user.save!
      end
      user
    end
  end
end
