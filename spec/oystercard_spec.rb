require 'oystercard'

describe Oystercard do
  subject(:card) { Oystercard.new }
  let(:station) { double "station"}
  describe '#Balance' do
    it 'should return a balance of zero when the card is initialised' do
      expect(card.balance).to eq 0
    end

    it 'adds balance when topped up' do
      expect(card.top_up(20)).to eq 20
    end

    it 'adds balance when topped up' do
      card.top_up(10)
      expect(card.top_up(20)).to eq 30
    end

    it 'throws an exception if the new balance exceeds £90' do
      card.top_up(Oystercard::LIMIT)
      expect { card.top_up(1) }.to raise_error "Exceeds limit of £#{Oystercard::LIMIT}"
    end

  end

  describe '#Journey' do
    it 'returns a success message when we touch_in' do
      card.top_up(10)
      expect(card.touch_in(station)).to eq [{entry: station, exit: nil}]
    end

    it 'touch_in returns true with predicate method in_journey?' do
      card.top_up(10)
      card.touch_in(station)
      expect(card).to be_in_journey
    end

    it 'returns a false boolean when touch_out' do
      card.top_up(30)
      card.touch_in(station)
      card.touch_out(station)
      expect(card).not_to be_in_journey
    end

    it 'returns false after touch_in and touch_out' do
      card.top_up(10)
      card.touch_in(station)
      card.touch_out(station)
      expect(card).not_to be_in_journey
    end

  end

  describe '#Min balance' do
      it 'raises error if balance is not min amount' do
        expect { card.touch_in(station) }.to raise_error "You need #{Oystercard::MINIMUM_FARE} for a journey"
      end
  end

  describe '#Charging for journey' do
    it 'test charging for journey' do
      card.top_up(10)
      card.touch_in(station)
      expect { card.touch_out(station) }.to change{ card.balance }.by(-Oystercard::MINIMUM_FARE)
    end
  end

  describe 'Storing a journey' do
    it 'when init Oystecard, journey array is empty' do
      expect(card.journey).to eq []
    end

    # it 'if touch in when in journey, deduct penalty fare' do
    #   card.top_up(20)
    #   card.touch_in(station)
    #   expect { card.touch_in(station) }.to change{ card.balance }.by(-Oystercard::PENALTY)
    # end

    it 'stores the entry station in the journey array' do
      card.top_up(20)
      card.touch_in(station)
      expect(card.journey).to eq [{entry: station, exit: nil}]
    end

    it 'stores the exit station in the journey array' do
      card.top_up(20)
      card.touch_in(station)
      card.touch_out(station)
      expect(card.journey).to eq [{entry: station, exit: station}]
    end
  end
end