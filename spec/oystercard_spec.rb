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
      expect(card.touch_in(station)).to eq station
    end

    it 'touch_in returns true with predicate method in_journey?' do
      card.top_up(10)
      card.touch_in(station)
      expect(card).to be_in_journey
    end

    it 'returns false with predicate method in_journey' do
      card.touch_out
      expect(card).not_to be_in_journey
    end

    it 'returns false after touch_in and touch_out' do
      card.top_up(10)
      card.touch_in(station)
      card.touch_out
      expect(card).not_to be_in_journey
    end

    it 'stores the current station when you touch in' do
      card.top_up(10)
      expect(card.touch_in(station)).to eq(station)
    end

    it 'resets entry station when you touch out' do
      card.top_up(10)
      card.touch_in(station)
      expect(card.touch_out).to eq nil
    end

  end

  describe '#Min balance' do
      it 'raises error if balance is not min amount' do
        expect { card.touch_in(station) }.to raise_error "You need #{Oystercard::MIN_AMOUNT} for a journey"
      end
  end

  describe '#Charging for journey' do
    it 'test charging for journey' do
      card.top_up(10)
      card.touch_in(station)
      expect { card.touch_out }.to change{ card.balance }.by(-Oystercard::MINIMUM_FARE)
    end
  end
end