require 'station'

describe Station do

  describe 'Initial test of intializing' do
    it 'should set station attribute name when created' do
      waterloo = Station.new(:waterloo, 1)
      expect(waterloo.name).to eq :waterloo
    end

    it 'should set station attribute zone when created' do
      waterloo = Station.new(:waterloo, 1)
      expect(waterloo.zone).to eq 1
    end

  end


end