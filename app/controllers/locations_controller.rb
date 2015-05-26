class LocationsController < ApplicationController

  def index
    @locations = Location.all
  end

  def show
    @location = Location.find(params[:id])
    @offset = params[:offset]
    if params[:date] && params[:time]
      @datetime = parse_datetime(params[:date], params[:time])
    elsif @offset
      @datetime = Time.now + @offset.to_i.days
    end
  end

end
