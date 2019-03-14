require_relative 'station'

class Journey
  attr_reader :entry_station, :exit_station, :fare
  MIN_FARE = 1
  PENALTY = 6

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = nil
    @fare = PENALTY
  end

  def finish(end_station)
    @exit_station = end_station
    return self
  end

  def calculate_fare
    @fare = MIN_FARE if complete?
  end 

  def complete?
    return true unless entry_station.nil? || exit_station.nil?
  end


end

station = Station.new("waterloo", 1)
station2 = Station.new("aldgate", 3)
new_journey = Journey.new(station)