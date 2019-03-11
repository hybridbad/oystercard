require 'oystercard'

describe Oystercard do

  subject(:card) {Oystercard.new}
  describe '#Balance' do

    it 'default balance is zero' do
      expect(card.balance).to eq Oystercard::START_BALANCE
    end
  end

  describe '#Top_up' do
    it 'Responds to top_up method' do
      expect(card).to respond_to(:top_up)
    end
  end

end
