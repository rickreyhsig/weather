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
      allow_any_instance_of(Services::FetchWeatherByZip).to receive(:process).and_return(nil)

      expect(subject).to receive(:fetch_by_zip)
      expect(subject).not_to receive(:fetch_by_city)

      subject.process(zip: '20906')
    end

    it 'gets response by city' do
      allow_any_instance_of(Services::FetchWeatherByCity).to receive(:process).and_return(nil)

      expect(subject).not_to receive(:fetch_by_zip)
      expect(subject).to receive(:fetch_by_city)

      subject.process(city: 'Silver Spring')
    end
  end
end
