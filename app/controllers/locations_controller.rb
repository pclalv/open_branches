class LocationsController < ApplicationController

  def index
    @locations = Location.all
  end

  def show
    @location = Location.find(params[:id])
    @offset = params[:offset]
    @datetime = parse_datetime(params[:date], params[:time]) if params[:date] && params[:time]
  end

end
