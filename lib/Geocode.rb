require 'httparty'
class Geocode
  BASE_URL = "https://maps.googleapis.com/maps/api/geocode/json?address="
  BASE_URL_DOS = "https://maps.googleapis.com/maps/api/geocode/json?latlng="
  BASE_URL_PLACES_DETAILS = "https://maps.googleapis.com/maps/api/place/details/json?placeid="
  KEY2 = ENV["GOOGLE_KEY"]

  attr_accessor :place_id, :formatted_address, :longitud, :latitud, :reference, :photo_reference
  def initialize(data, lat = nil, long = nil)
    if data == nil
      @latitud = lat
      @longitud = long
    else
      hash = data["result"]
      @place_id =  hash["place_id"]
      @formatted_address = hash["formatted_address"]
      @latitud = hash["geometry"]["location"]["lat"]
      @longitud = hash["geometry"]["location"]["lng"]
      if hash['photos'] != nil
        @photo_reference = hash['photos'].first['photo_reference']
      end
      @reference = hash["reference"]
    end
  end

  def self.find_destination(lat, long)
    data = HTTParty.get(BASE_URL_DOS + "#{lat},#{long}").parsed_response
    if data["status"] == "ZERO_RESULTS"
      return self.new(nil, lat, long)
    else
      id = data["results"].first["place_id"]
      details = HTTParty.get(BASE_URL_PLACES_DETAILS + id + "&key=" + KEY2).parsed_response
      return self.new(details)
    end
  end

  def self.find(user_input)
    data = HTTParty.get(BASE_URL + user_input).parsed_response
    id = data["results"].first["place_id"]
    details = HTTParty.get(BASE_URL_PLACES_DETAILS + id + "&key=" + KEY2).parsed_response
    return self.new(details)
  end

end
