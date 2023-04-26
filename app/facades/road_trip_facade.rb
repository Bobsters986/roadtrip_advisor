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

      trip_start_time = forecast_at_destination[:location][:localtime]
      trip_arrival_time = get_arrival_time(travel_time)

      arrival_day_index = (trip_arrival_time.to_date - trip_start_time.to_date).to_i
      exact_hour = trip_arrival_time.strftime("%H").to_i

      arrival_weather = forecast_at_destination[:forecast][:forecastday][arrival_day_index][:hour][exact_hour]

      weather_at_eta = create_weather_hash(arrival_weather)
        
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
    trip_hours = time[0].to_i
    trip_days = (trip_hours / 24).to_i
  end

  def get_arrival_time(travel_time)
    time = travel_time.split(":")
    trip_hours = time[0].to_i
    trip_minutes = time[1].to_i

    arrival_time = Time.now + trip_hours.hours + trip_minutes.minutes
  end

  def create_weather_hash(arrival_weather)
    {
      datetime: arrival_weather[:time],
      temperature: arrival_weather[:temp_f],
      conditions: arrival_weather[:condition][:text]
    }
  end

  private

  def road_trip_data
    @road_trip_data ||= MapquestService.get_travel_info(origin, destination)
  end
end
