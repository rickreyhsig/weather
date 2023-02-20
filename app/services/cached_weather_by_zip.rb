module Services
  class CachedWeatherByZip
    CACHE_EXPIRATION = 30.minutes

    def process(client, zip, country = 'US', cache = false)
      cache = Rails.cache.read("weather_by_zip/#{zip}")
      if cache.present?
        response = fetch_by_zip(client, zip, country, cache)
      else
        response = fetch_by_zip(client, zip, country, false)
        Rails.cache.write("weather_by_zip/#{zip}", response, expires_in: CACHE_EXPIRATION)
      end

      return response
    end

    private

    def fetch_by_zip(client, zip, country, cache)
      Services::FetchWeatherByZip.new.process(
        client, zip, country, cache
      )
    end
  end
end
