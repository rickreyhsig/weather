# README
Please set the environment variables according to the Configuration section.

* Ruby version
  * `ruby 2.5.9p229 (2021-04-05 revision 67939) [x86_64-darwin16]`

* Configuration
  Please set your `config/environment.yml` like such:
```
  development:
    open_weather_api_key: '<development_key>'
  production
    open_weather_api_key: '<production_key>'
 ```

* Database creation
  * `rake db:create`

* Database initialization
  * `rake db:schema:load`

* How to run the test suite
  * `bundle exec rspec spec/services/weather_forecast_spec.rb`
  * `bundle exec rspec spec/services/fetch_weather_by_zip_spec.rb`
  * `bundle exec rspec spec/services/fetch_weather_by_city_spec.rb`

