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
    return unless self.class.has_food?(foursquare_checkin["venue"])
    checkins.create(
      :venue_id      => foursquare_checkin["venue"]["id"],
      :foursquare_id => foursquare_checkin["id"]
    )
  end

  def foods_at(venue_id)
    foods.where(:checkins => {:venue_id => venue_id})
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

    def has_food?(venue)
      categories = venue["categories"].map do |category|
        category["id"]
      end
      (categories & FOOD_CATEGORIES).any?
    end
  end

  FOOD_CATEGORIES = %w[
    4d4b7105d754a06374d81259
    503288ae91d4c4b30a586d67
    4bf58dd8d48988d1c8941735
    4bf58dd8d48988d14e941735
    4bf58dd8d48988d152941735
    4bf58dd8d48988d107941735
    4bf58dd8d48988d142941735
    4bf58dd8d48988d169941735
    4bf58dd8d48988d1df931735
    4bf58dd8d48988d179941735
    4bf58dd8d48988d16a941735
    4bf58dd8d48988d16b941735
    4bf58dd8d48988d143941735
    50327c8591d4c4b30a586d5d
    4bf58dd8d48988d16c941735
    4bf58dd8d48988d153941735
    4bf58dd8d48988d16d941735
    4bf58dd8d48988d17a941735
    4bf58dd8d48988d144941735
    4bf58dd8d48988d145941735
    4bf58dd8d48988d1e0931735
    4bf58dd8d48988d154941735
    4bf58dd8d48988d1bc941735
    4bf58dd8d48988d146941735
    4bf58dd8d48988d1d0941735
    4bf58dd8d48988d1f5931735
    4bf58dd8d48988d147941735
    4e0e22f5a56208c4ea9a85a0
    4bf58dd8d48988d148941735
    4bf58dd8d48988d108941735
    4bf58dd8d48988d109941735
    4bf58dd8d48988d10a941735
    4bf58dd8d48988d10b941735
    4bf58dd8d48988d16e941735
    4eb1bd1c3b7b55596b4a748f
    4edd64a0c7ddd24ca188df1a
    4bf58dd8d48988d1cb941735
    4bf58dd8d48988d10c941735
    4d4ae6fc7a7b7dea34424761
    4bf58dd8d48988d155941735
    4bf58dd8d48988d10d941735
    4c2cd86ed066bed06c3c5209
    4bf58dd8d48988d10e941735
    4bf58dd8d48988d16f941735
    4bf58dd8d48988d1c9941735
    4bf58dd8d48988d10f941735
    4deefc054765f83613cdba6f
    4bf58dd8d48988d110941735
    4bf58dd8d48988d111941735
    4bf58dd8d48988d112941735
    4bf58dd8d48988d113941735
    4bf58dd8d48988d1be941735
    4bf58dd8d48988d1bf941735
    4bf58dd8d48988d156941735
    4bf58dd8d48988d1c0941735
    4bf58dd8d48988d1c1941735
    4bf58dd8d48988d115941735
    4bf58dd8d48988d1c2941735
    4eb1d5724b900d56c88a45fe
    4bf58dd8d48988d1c3941735
    4bf58dd8d48988d157941735
    4eb1bfa43b7b52c0e1adc2e8
    4bf58dd8d48988d1ca941735
    4def73e84765ae376e57713a
    4bf58dd8d48988d1d1941735
    4bf58dd8d48988d1c4941735
    4bf58dd8d48988d1bd941735
    4bf58dd8d48988d1c5941735
    4bf58dd8d48988d1c6941735
    4bf58dd8d48988d1ce941735
    4bf58dd8d48988d1c7941735
    4bf58dd8d48988d1dd931735
    4bf58dd8d48988d1cd941735
    4bf58dd8d48988d14f941735
    4bf58dd8d48988d150941735
    4bf58dd8d48988d14d941735
    4bf58dd8d48988d1cc941735
    4bf58dd8d48988d1d2941735
    4bf58dd8d48988d158941735
    4bf58dd8d48988d151941735
    4bf58dd8d48988d1db931735
    4bf58dd8d48988d1dc931735
    4bf58dd8d48988d149941735
    4f04af1f2fb6e1c99f3db0bb
    4bf58dd8d48988d1d3941735
    4bf58dd8d48988d14a941735
    4bf58dd8d48988d14b941735
    4bf58dd8d48988d14c941735
  ]
end
