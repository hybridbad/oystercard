require_relative 'journey'
require_relative 'station'

class Oystercard
  attr_reader :balance, :entry_station, :journey
  LIMIT = 90
  MINIMUM_FARE = 1
  PENALTY = 10

  def initialize(balance = 0)
    @balance = balance
    @journey = []
  end

  def top_up(amount)
    raise "Exceeds limit of £#{LIMIT}" if @balance + amount > LIMIT
    @balance += amount
  end

  def in_journey?
    return true if @journey[-1][:exit] == nil
  end

  def touch_in(station)
    raise "You need #{MINIMUM_FARE} for a journey" if @balance < MINIMUM_FARE
    @journey << {entry: station, exit: nil}
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @journey[-1][:exit] = exit_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end