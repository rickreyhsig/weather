module Services
  class WeatherForecast

    def initialize
      @client = OpenWeather::Client.new
    end

    def process(options = {})
      if options[:city].blank? && options[:zip].blank?
        return missing_options_response
      elsif options[:zip].present?
        parsed_response = fetch_by_zip(options)
      else
        parsed_response = fetch_by_city(options)
      end
      return parsed_response
    end

    private

    def missing_options_response
      {
        data: nil,
        error: 'Please pass in a city OR zip.',
        cache: false
      }.to_json
    end

    def fetch_by_zip(options)
      Services::CachedWeatherByZip.new.process(
        @client, options[:zip], options[:country]
      )
    end

    def fetch_by_city(options)
      Services::FetchWeatherByCity.new.process(
        @client, options[:city]
      )
    end

    ### TODO
    # Frontend
    ###
  end
end
