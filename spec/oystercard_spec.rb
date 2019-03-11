require 'oystercard'

describe Oystercard do

  subject(:card) {Oystercard.new}

  describe '#Balance' do

    it 'default balance is zero' do
      expect(card.balance).to eq 0
    end

  end

  describe '#Top_up' do

    it 'Balance should change when topped up' do
      expect{ card.top_up 30}.to change{ subject.balance }.by 30
    end

    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAX_BALANCE
      card.top_up(maximum_balance)
      expect{ card.top_up 1 }.to raise_error("Maximum balance of #{maximum_balance} exceeded")
    end

  end

  describe '#deduct' do 

    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'balance should change when deducted' do 
      card.top_up(20)
      expect{ card.deduct 3}.to change{ card.balance }.by -3
    end

  end

  describe '#journey' do 

    it 'is initially not in a journey' do
      expect(card).not_to be_in_journey
    end

    # it 'allows the customer to touch in and pass through the barriers' do
    #   expect(card).to respond_to(:touch_in)
    # end

    # it 'allows the customer to touch out and pass through the barriers' do
    #   expect(card).to respond_to(:touch_out)
    # end

    # it 'starts a journey when you touch in' do 
    #   expect(card.touch_in).to eq(true)
    # end

    # it 'ends a journey when you touch out' do 
    #   expect(card.touch_out).to eq(false)
    # end

  end

end




