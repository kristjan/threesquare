class FoodsController < ApplicationController
  def new
    @checkin = Checkin.find(params[:checkin_id])
    @food = @checkin.foods.new
  end
end
