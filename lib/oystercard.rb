class Oystercard

  MAX_BALANCE = 90

  attr_reader :balance

  def initialize(journey = false)
    @balance = 0
    @journey = journey
  end

  def top_up(amount)
    fail 'Maximum balance of 90 exceeded' if amount + balance > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    false
  end

  # def touch_in
  #   journey = true
  # end

  # def touch_out
  #   journey = false
  # end

end
