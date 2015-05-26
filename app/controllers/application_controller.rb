class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def parse_datetime(date, time)
    year, month, day = date.split('-').map(&:to_i)
    hour, minute = time.split(":").map(&:to_i)

    Time.new(year, month, day, hour, minute)
  end
end
