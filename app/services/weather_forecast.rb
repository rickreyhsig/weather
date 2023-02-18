module Services
  class WeatherForecast
    def initialize
      @client = OpenWeather::Client.new
    end

    def process(options = {})
      if options[:city].blank? && options[:zip].blank?
        response = {data: nil, error: 'Please pass in a city OR zip.', cache: false}.to_json
      elsif options[:zip].present?
        response = fetch_by_zip(options[:zip], options[:country])
      else
        response = fetch_by_city(options[:city])
      end
      return response
    end

    private

    # TODO
    # Caching
    # Move by zip to it's class
    # Move by city to it's class
    # Finish specs
    # Rm comments

    def fetch_by_zip(zip, country = 'US')
      begin
        data = @client.current_zip(zip, country = 'US')
        temperatures = {
          current_temp: data.main.temp_f,
          high: data.main.temp_max_f,
          low: data.main.temp_min_f
        }
        response = {data: temperatures, error: nil, cache: false}
      rescue Faraday::ResourceNotFound
        response = {data: nil, error: 'API error - resource not found', cache: false}
        return response.to_json
      end
      return response.to_json
    end

    def fetch_by_city(city)
      begin
        data = @client.current_weather(city: city)
        temperatures = {
          current_temp: data.main.temp_f,
          high: data.main.temp_max_f,
          low: data.main.temp_min_f
        }
        response = {data: temperatures, error: nil, cache: false}
      rescue Faraday::ResourceNotFound
        response = {data: nil, error: 'API error - resource not found', cache: false}
        return response.to_json
      end
      return response.to_json
    end
  end
end

=begin
  wf = Services::WeatherForecast.new
  data = wf.fetch_by_zip('20906') OR wf.fetch_by_zip('20906', 'US')
  data = wf.fetch_by_city('Silver Spring')
  data.main.temp_f
  data.main.temp_max_f
  data.main.temp_min_f
=end