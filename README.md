# Weather Forecast


## Loom Video:
https://www.loom.com/share/cd1fddae70cf464d88cd9d56f36c464e

## Specification:
<img width="587" alt="Screen Shot 2023-03-28 at 8 48 11 PM" src="https://user-images.githubusercontent.com/2385700/228391485-64e181c8-65ab-4f25-a8e3-c1516e52f29a.png">

## Proposed Solution
Use the open-weather-ruby-client gem to obtain weather information and cache details for requests by zip and display those results to the user.

## Sequence Diagrams
<img width="1670" alt="Screen Shot 2023-03-29 at 6 41 40 PM" src="https://user-images.githubusercontent.com/2385700/228674438-6067571c-01fb-4a6f-a451-b19917981650.png">

## Libraries / Tools Used

* Ruby version
  * `ruby 2.5.9p229 (2021-04-05 revision 67939) [x86_64-darwin16]`

* Rails 
  * `Rails 5.2.8.1`

## Configuration

  Please set your `config/environment.yml` like such:
```
  development:
    open_weather_api_key: '<development_key>'
  production
    open_weather_api_key: '<production_key>'
 ```

## Setup
* Database creation
  * `rake db:create`

* Database initialization
  * `rake db:schema:load`

* How to run the test suite
  * `bundle exec rspec spec/services`
  OR individually:
  * `bundle exec rspec spec/services/weather_forecast_spec.rb`
  * `bundle exec rspec spec/services/fetch_weather_by_zip_spec.rb`
  * `bundle exec rspec spec/services/fetch_weather_by_city_spec.rb`
  * `bundle exec rspec spec/services/cached_weather_by_zip_spec.rb`

