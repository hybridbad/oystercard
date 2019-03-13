class Journey
  attr_reader :entry_station, :exit_station

  def initialize
    @entry_station
    @exit_station
  end

  def start_journey(entry)
    @entry_station = entry
  end

  def end_journey(exit_stn)
    @exit_station = exit_stn
  end

end