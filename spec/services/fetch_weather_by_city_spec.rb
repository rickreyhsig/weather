require 'rails_helper'

describe Services::FetchWeatherByCity do
  client = OpenWeather::Client.new
  subject { described_class }

  describe 'process' do
    it 'when no params are provided, an error is triggered' do
      expect { subject.process }.to raise_error(ArgumentError)
      expect { subject.process(client) }.to raise_error(ArgumentError)
    end

    it 'returns response when client and zip are provided' do
      zip = '20906'
      response = {
        data: {
          current_temp: 30.51, high: 33.71, low: 27.79
        },
        error: nil,
        cache: false
      }.to_json
      allow(subject).to receive(:process) { response }
      expect(subject.process(client, response)).to eq(response)
    end
  end
end
