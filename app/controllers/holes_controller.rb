require "#{Rails.root}/lib/Geocode.rb"
class HolesController < ApplicationController
  before_action :require_login, only: [:create, :show, :destroy]

  def index

  end
  def new
    @hole = Hole.new
  end

  def create
    @hole = Hole.new
    @hole.current_user_id = params[:current_user_id]
    @hole.origen_address = params[:origen_address]
    @hole.origin_latitud = params[:origin_latitud]
    @hole.origin_longitud = params[:origin_longitud]
    @hole.origin_image = params[:origin_image]
    @hole.destination_address = params[:destination_address]
    @hole.destination_latitud = params[:destination_latitud]
    @hole.destination_longitud = params[:destination_longitud]
    @hole.destination_image = params[:destination_image]

    @hole.save
    if @hole.save
      redirect_to hole_path(@hole.current_user_id)
    else
      render :index
    end
  end

  def show
    @holes = Hole.where(current_user_id: params[:id])
  end

  def destroy
    Hole.delete(params[:id])
    redirect_to hole_path(current_user.uid)
  end


  def search_result
    data = Geocode.find(params[:user_input])
    if data.nil?
      flash.now[:notice] = "Something went wrong, please try again"
    else
      @location = data
      @user_input = params[:user_input]
      @destination_latitud = @location.latitud
      @destination_longitud = @location.longitud * (-1)
      @destination = Geocode.find_destination(@destination_latitud,@destination_longitud)
      if @destination.formatted_address
         if @destination.formatted_address.include? "China"
           place = @destination.formatted_address.split(',')
           if place[0][/\d+/].nil?
             @destination = Geocode.find("#{place[0]}, #{place[1]}")
           else
             @destination = Geocode.find(place[1])
         end
        end
      end
      render :index
    end

  end
end
