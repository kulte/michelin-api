class Api::AreasController < ApplicationController
  def index
    @areas = Area.all
    render json: @areas
  end

  def show
    @area = Area.find(params[:id])
    render json: @area
  end
end
