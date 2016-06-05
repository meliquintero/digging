require "#{Rails.root}/lib/Geocode.rb"
class HolesController < ApplicationController
  def show
  end


  def search_result
    data = Geocode.find(params[:user_input])
    if data.nil?
      flash.now[:notice] = "Something went wrong, please try again"
    else
      @location = data
      @user_input = params[:user_input]
      @destination_latitud = @location.latitud
      @destination_longitud = @location.longitud.abs
      @destination = Geocode.find_destination(@destination_latitud,@destination_longitud)
      
      render :show
    end

  end
end
