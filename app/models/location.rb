require 'net/http'

class Location

  SOURCE = 'http://locations.api.nypl.org/api/v0.7.1/locations/'

  attr_reader :name, :slug, :hours

  def self.all
    @all ||= {}

    if @all == {}
      resp = Net::HTTP.get_response(URI.parse(SOURCE))
      data = resp.body
      result = JSON.parse(data)
      result["locations"].each do |loc_data|
        @all[loc_data["slug"]] = Location.new(loc_data)
      end
    end

    @all.values
  end

  def self.find(slug)
    @all ? @all[slug] : self.fetch(slug)
  end

  def self.fetch(slug)
    resp = Net::HTTP.get_response(URI.parse("#{SOURCE}/#{slug}"))
    data = resp.body
    result = JSON.parse(data)
    Location.new(result["location"])
  end

  def initialize(loc_data)
    @name = loc_data["name"]
    @slug = loc_data["slug"]
    @hours = loc_data["hours"]["regular"]
  end

  def open?(offset = nil, datetime = nil)
    time_now = datetime || Time.now + offset.to_i.days
    hours = @hours[time_now.wday]

    if hours["open"] && hours["open"].to_i <= time_now.hour && time_now.hour <= hours["close"].to_i
      "open"
    else
      "closed"
    end
  end

  def hours_at(datetime)
    hour = @hours[datetime.wday]
    hour["open"] ? "open from #{hour["open"]} til #{hour["close"]}" : "closed"
  end

end
