class WeathersController < ApplicationController

  # GET /weather
  def index
  end

  # POST /weather
  def show
    if params['zip'].present?
      response = Services::WeatherForecast.new.process(zip: params['zip'])
      @response = JSON.parse(response)
      render :show
    elsif params['city'].present?
      response = Services::WeatherForecast.new.process(city: params['city'])
      @response = JSON.parse(response)
      render :show
    else
      render json: { errors: 'Please pass in a city OR zip.' }
    end
  end
end
