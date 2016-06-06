require 'httparty'
class Geocode
  BASE_URL = "https://maps.googleapis.com/maps/api/geocode/json?address="
  BASE_URL_DOS = "https://maps.googleapis.com/maps/api/geocode/json?latlng="
  attr_accessor :place_id, :formatted_address, :location, :longitud, :latitud, :viewport, :geometry
  def initialize(data)
    if data["status"] == "ZERO_RESULTS"
      @place_id = nil
      @formatted_address = nil
      @geometry = nil
      @location = nil
      @latitud = nil
      @longitud = nil
    else
      hash = data["results"][0]
      @place_id =  hash["place_id"]
      @formatted_address = hash["formatted_address"]
      @geometry = hash["geometry"]
      @location = @geometry["location"]
      @latitud = @geometry["location"]["lat"]
      @longitud = @geometry["location"]["lng"]
    end
  end

  def self.find_destination(lat, long)
    data = HTTParty.get(BASE_URL_DOS + "#{lat},#{long}").parsed_response
    return self.new(data)
  end

  def self.find(user_input)
    data = HTTParty.get(BASE_URL + user_input).parsed_response
    return self.new(data)
  end

end
