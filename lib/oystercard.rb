class Oystercard

    attr_reader :balance, :entry_station, :exit_station, :history

    LIMIT = 90
    MINIMUM = 1

    def initialize
      @balance = 0
      @entry_station = nil
      @exit_station = nil
      @history = {}
    end

    def top_up(value)
      fail "£#{LIMIT} limit exceeded" if balance + value > LIMIT
      @balance += value
    end

    def in_journey?
      @entry_station != nil
    end

    def touch_in(station)
      fail "Not enough balance" if balance < MINIMUM
      @entry_station = station
      @history[:entry_station] = station
  
    end

    def touch_out(exit_station)
      deduct(MINIMUM)
      @entry_station = nil
      @exit_station = exit_station
      @history[:exit_station] = exit_station
    end

   private

    def deduct(value)
      @balance -= value
    end

  end
