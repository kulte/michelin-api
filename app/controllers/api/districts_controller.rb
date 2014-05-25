class Api::DistrictsController < ApplicationController
  def index
    @districts = District.all
    render json: @districts
  end

  def show
    @district = District.find(params[:id])
    render json: @district
  end
end
