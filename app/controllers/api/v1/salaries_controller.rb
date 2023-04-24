class Api::V1::SalariesController < ApplicationController
  def show
    destination = params[:destination].downcase

    city_info = TeleportFacade.city_info(destination)
    render json: SalariesSerializer.new(city_info)
  end
end