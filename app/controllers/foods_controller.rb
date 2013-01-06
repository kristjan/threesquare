class FoodsController < ApplicationController
  def new
    @checkin = Checkin.find(params[:checkin_id])
    @food = @checkin.foods.new
  end

  def create
    @food = Food.new(params[:food])
    if @food.save
      redirect_to checkin_food_url(@food.checkin, @food,
                    :redirect_url => params[:redirect_url]
                  )
    else
      render :json => @food.errors
    end
  end

  def show
    @food = Food.find(params[:id])
    @redirect = params[:redirect_url] || root_path
  end
end
