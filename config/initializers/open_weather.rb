OpenWeather::Client.configure do |config|
  config.api_key = Rails.application.config_for(:environment)['open_weather_api_key']
  config.user_agent = 'OpenWeather Ruby Client/1.0'
end

=begin
  client = OpenWeather::Client.new

  data = client.current_weather(city: 'Silver Spring')

  data = client.current_zip(20906, 'US')

  CURRENT TEMP - data.main.temp_f

  HIGH - data.main.temp_max_f

  LOW - data.main.temp_min_f
=end