module Services
  class FetchWeatherByCity

    def process(client, city)
      begin
        data = client.current_weather(city: city)
        parsed_response = parse_response(data)
      rescue Faraday::ResourceNotFound
        return resource_not_found_response
      end
      return parsed_response
    end

    private

    def temperatures(data)
      {
        current_temp: data.main.temp_f,
        high: data.main.temp_max_f,
        low: data.main.temp_min_f
      }
    end

    def parse_response(data)
      {
        data: temperatures(data),
        error: nil,
        cache: false
      }.to_json
    end

    def resource_not_found_response
      {
        data: nil,
        error: 'API error - resource not found',
        cache: false
      }.to_json
    end
  end
end
