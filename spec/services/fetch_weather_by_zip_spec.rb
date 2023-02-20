require 'rails_helper'

describe Services::FetchWeatherByZip do
  client = OpenWeather::Client.new
  subject { described_class.new }

  describe 'process' do
    it 'when no params are provided, an error is triggered' do
      expect { subject.process }.to raise_error(ArgumentError)
      expect { subject.process(client) }.to raise_error(ArgumentError)
    end

    it 'returns response when client and zip are provided' do
      zip = '20906'
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
      allow(client).to receive(:current_zip) { data }
      expect(subject.process(client, zip)).to eq(expected_response)
    end
  end
end
