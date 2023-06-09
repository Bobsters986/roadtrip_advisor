class MapquestService

  def self.get_coordinates(location)
    response = conn.get('geocoding/v1/address') do |req|
      req.params['key'] = ENV['MAPQUEST_API_KEY']
      req.params['location'] = location
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_travel_info(origin, destination)
    response = conn.get('directions/v2/route') do |req|
      req.params['key'] = ENV['MAPQUEST_API_KEY']
      req.params['from'] = origin
      req.params['to'] = destination
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com')
  end
end