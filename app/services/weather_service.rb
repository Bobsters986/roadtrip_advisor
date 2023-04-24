class WeatherService

  def self.forecast(lat, lng)
    response = conn.get('forecast.json') do |req|
      req.params['key'] = ENV['WEATHER_API_KEY']
      req.params['q'] = "#{lat},#{lng}"
      req.params['days'] = 5
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.city_name_forecast(destination)
    response = conn.get('forecast.json') do |req|
      req.params['key'] = ENV['WEATHER_API_KEY']
      req.params['q'] = destination
      req.params['days'] = 5
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new(url: 'http://api.weatherapi.com/v1/')
  end
end