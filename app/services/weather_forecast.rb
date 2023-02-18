module Services
  class WeatherForecast
    include Services::FetchWeatherByZip
    include Services::FetchWeatherByCity

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
      Services::FetchWeatherByZip.process(
        @client, options[:zip], options[:country]
      )
    end

    def fetch_by_city(options)
      Services::FetchWeatherByCity.process(
        @client, options[:city]
      )
    end

    ### TODO
    # Caching wrapper
    # Caching specs
    # Rm comments
    ###
  end
end

=begin
  wf = Services::WeatherForecast.new
  wf.process(zip: '20906')
  wf.process(city: 'Silver Spring')
=end