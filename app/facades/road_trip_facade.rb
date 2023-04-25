class RoadTripFacade
  attr_reader :origin, :destination

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def new_adventure
    if road_trip_data[:info][:statuscode] == 402
      travel_time = "Impossible Route"
      weather_at_eta = {}

      RoadTrip.new(origin, destination, travel_time, weather_at_eta)
    else
      travel_time = road_trip_data[:route][:formattedTime]


      RoadTrip.new(origin, destination, travel_time, weather_at_eta)
    end
  end

  def forecast_at_destination
    lat = road_trip_data[:route][:locations].last[:latLng][:lat]
    lng = road_trip_data[:route][:locations].last[:latLng][:lng]

    WeatherService.forecast(lat, lng)
  end

  def days_of_travel(travel_time)
    time = travel_time.split(":")
    hours = time[0].to_i
    days = (hours / 24).to_i
  end

  private

  def road_trip_data
    @road_trip_data ||= MapquestService.get_travel_info(origin, destination)
  end

end
# weather_at_eta = WeatherFacade.new(road_trip_data[:route][:locations].last[:latLng][:lat], road_trip_data[:route][:locations].last[:latLng][:lng]).weather_at_eta(travel_time)
# weather_at_eta = WeatherService.forecast(road_trip_data[:route][:locations][1][:latLng], road_trip_data[:route][:locations][1][:latLng])
