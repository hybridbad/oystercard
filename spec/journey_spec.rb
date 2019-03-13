require 'journey'

describe Journey do
  subject(:current) { Journey.new }
  describe 'Create journey object' do

    it { is_expected.to respond_to(:start_journey).with(1).argument }

    it 'stores entry as the entry station attribute' do
      expect(current.start_journey("waterloo")).to eq current.entry_station
    end

    it 'stores exit_stn as the exit_station attribute' do
      expect(current.end_journey("aldgate east")).to eq current.exit_station
    end
  end


end