class CityInfo
  attr_reader :id,
              :destination,
              :forecast,
              :salaries

  def initialize(id = nil, destination, forecast, salaries)
    @destination = destination
    @forecast = forecast
    @salaries = salaries
  end
end