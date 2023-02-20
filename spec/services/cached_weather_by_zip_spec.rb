require 'rails_helper'

describe Services::CachedWeatherByZip do
  client = OpenWeather::Client.new
  subject { described_class.new }

  describe 'process' do
    it 'when no params are provided, an error is triggered' do
      expect { subject.process }.to raise_error(ArgumentError)
      expect { subject.process(client) }.to raise_error(ArgumentError)
    end

    it 'when cache is empty, it returns a non-cached response; when cache has key, it returns the cached response' do
      zip = '20907'
      cur_tmp = 30.51
      high = 33.71
      low = 27.79
      data = OpenStruct.new(
        main: OpenStruct.new(
          temp_f: cur_tmp,
          temp_max_f: high,
          temp_min_f: low)
      )
      expected_response = {
        data: {
          current_temp: cur_tmp, high: high, low: low
        },
        error: nil,
        cache: false
      }.to_json

      cached_response = {
        data: {
          current_temp: cur_tmp, high: high, low: low
        },
        error: nil,
        cache: true
      }.to_json
      allow(client).to receive(:current_zip) { data }

      Rails.cache.delete("weather_by_zip/#{zip}")
      expect(subject.process(client, zip)).to eq(expected_response)
      expect(subject.process(client, zip)).to eq(cached_response)
    end
  end
end
