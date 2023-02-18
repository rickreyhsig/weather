require 'rails_helper'

describe Services::WeatherForecast do
  subject { described_class.new }

  describe 'process' do
  
    it 'when no params are provided, an error is triggered' do
      error_response = {
        data: nil,
        error: 'Please pass in a city OR zip.',
        cache: false
      }.to_json
      expect(subject.process()).to eq(error_response)
    end

    it 'gets response by zip' do
      zip = '20906'
      zip_response = {
        data: {
          current_temp: 30.51, high: 33.71, low: 27.79
        },
        error: nil,
        cache: false
      }.to_json
      allow(subject).to receive(:process).with(zip: zip) { zip_response }
      expect(subject.process(zip: zip)).to eq(zip_response)
    end

    it 'gets response by city' do
      city = 'Silver Spring'
      city_response = {
        data: {
          current_temp: 39.76, high: 42.17, low: 37.85
        },
        error: nil,
        cache: false
      }.to_json
      allow(subject).to receive(:process).with(city: city) { city_response }
      expect(subject.process(city: city)).to eq(city_response)
    end


    # xit "gets response from cache" do
    #   zip_response = {
    #     data: {
    #       current_temp: 30.51, high: 33.71, low: 27.79
    #     },
    #      error: nil,
    #      cache: false
    #   }.to_json
    #   allow(subject).to receive(:process).with(zip: '20906') { zip_response }
    #   expect(subject.process(zip: '20906')).to eq(zip_response)
    # end

  end

end
