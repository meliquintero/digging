require 'httparty'
class Geocode
  BASE_URL = "https://maps.googleapis.com/maps/api/geocode/json?address="
  attr_reader :place_id, :formatted_address, :location, :longitud, :latitud, :viewport, :geometry
  def initialize(data)
    data["results"].collect do |hash|
      @place_id =  hash["place_id"]
      @formatted_address = hash["formatted_address"].first
      @geometry = hash["geometry"]
    end
    @location = @geometry["location"]
    @latitud = @geometry["location"]["lat"]
    @longitud = @geometry["location"]["lng"]
  end

  def self.find(user_input)
    data = HTTParty.get(BASE_URL + user_input).parsed_response
    return self.new(data)
  end
end
