class Oystercard
  attr_reader :balance, :entry_station
  MIN_AMOUNT = 1
  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
  end

  def top_up(amount)
    raise "Exceeds limit of £#{LIMIT}" if @balance + amount > LIMIT
    @balance += amount
  end

  def in_journey?
    return true if !@entry_station.nil?
  end

  def touch_in(station)
    raise "You need #{MIN_AMOUNT} for a journey" if @balance < MIN_AMOUNT
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end