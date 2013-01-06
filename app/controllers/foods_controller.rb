class FoodsController < ApplicationController
  def new
    @checkin = Checkin.find(params[:checkin_id])
    @food = @checkin.foods.new
  end

  def create
    @food = Food.new(params[:food])
    if @food.save
      render :text => "Got it!"
    else
      render :json => @food.errors
    end
  end
end
