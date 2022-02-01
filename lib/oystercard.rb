class Oystercard

    attr_reader :balance
    LIMIT = 90

    def initialize
      @balance = 0
    end

    def top_up(value)
      fail "£#{LIMIT} limit exceeded" if balance + value > LIMIT
      @balance += value
    end

  end