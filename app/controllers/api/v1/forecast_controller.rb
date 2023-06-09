class Api::V1::ForecastController < ApplicationController
  def index
    forecast = WeatherFacade.get_forecast(params[:location])
    render json: ForecastSerializer.new(forecast)
  end
end