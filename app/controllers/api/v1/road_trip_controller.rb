class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    
    if !params[:origin].present? || !params[:destination].present?
      render json: { errors: "Origin and/or destination can't be blank" }, status: :bad_request
    elsif user
      road_trip = RoadTripFacade.new(params[:origin], params[:destination]).new_adventure
      render json: RoadTripSerializer.new(road_trip), status: :created
    else
      render json: { errors: 'Unauthorized' }, status: :unauthorized
    end
  end
end
