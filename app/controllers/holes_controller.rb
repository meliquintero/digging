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
      render :show
    end

  end
end
