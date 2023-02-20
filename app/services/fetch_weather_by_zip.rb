module Services
  class FetchWeatherByZip

    def process(client, zip, country = 'US', cache = false)
      return cached_response(cache) if cache.present?
      begin
        data = client.current_zip(zip, country = 'US')
        parsed_response = parse_response(data, cache)
      rescue Faraday::ResourceNotFound
        return resource_not_found_response
      rescue Faraday::ConnectionFailed
        return api_not_found_response
      end
      return parsed_response
    end

    private

    def cached_response(cache)
      cached_response = {}
      JSON.parse(cache).each do |key, value|
        cached_response[key] = value unless key == 'cache'
      end
      cached_response['cache'] = true
      return cached_response.to_json
    end

    def temperatures(data)
      {
        current_temp: data.main.temp_f,
        high: data.main.temp_max_f,
        low: data.main.temp_min_f
      }
    end

    def parse_response(data, cache)
      {
        data: temperatures(data),
        error: nil,
        cache: cache
      }.to_json
    end

    def resource_not_found_response
      {
        data: nil,
        error: 'API error - resource not found',
        cache: false
      }.to_json
    end

    def api_not_found_response
      {
        data: nil,
        error: 'API error - timeout',
        cache: false
      }.to_json
    end
  end
end
