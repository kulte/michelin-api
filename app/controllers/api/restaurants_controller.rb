class Api::RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant
      .filter(filter_params)
      .page(params[:page])
      .per(params[:per_page])

    render json: @restaurants
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    render json: @restaurant
  end

  private

  def filter_params
    params.slice(:stars, :comfort, :chef)
  end
end
