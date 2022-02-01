class Oystercard

    attr_reader :balance
    LIMIT = 90
    MINIMUM = 1

    def initialize
      @balance = 0
      @in_journey = false
    end

    def top_up(value)
      fail "£#{LIMIT} limit exceeded" if balance + value > LIMIT
      @balance += value
    end

    def in_journey?
      @in_journey
    end

    def touch_in
      fail "Not enough balance" if balance < MINIMUM
      @in_journey = true
    end

    def touch_out
      deduct(MINIMUM)
      @in_journey = false
    end

  # private

    def deduct(value)
      @balance -= value
    end

  end
