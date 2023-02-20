OpenWeather::Client.configure do |config|
  config.api_key = Rails.application.config_for(:environment)['open_weather_api_key']
  config.user_agent = 'OpenWeather Ruby Client/1.0'
end
