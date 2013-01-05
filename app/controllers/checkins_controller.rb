class CheckinsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    checkin = JSON.parse(params['checkin'])
    # TODO: verify push secret
    user = FoursquareUser.find_by_foursquare_id(checkin['user']['id'])
    user.check_in(checkin)
    return head :ok
  end
end
