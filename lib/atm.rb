class Atm
    attr_accessor :funds

    def initialize
        @funds = 1000
    end

    def withdraw(amount, pin_code, account)
      case
      when insufficient_funds_in_account?(amount, account)  then
        { status: true, message: 'insufficient funds', date: Date.today }
      when insufficient_funds_in_atm?(amount) then
        {status: false, message: 'insufficient funds in ATM', date: Date.today}
      when incorrect_pin?(pin_code, account.pin_code) then
        { status: false, message: 'wrong pin', date: Date.today }
      else
        perform_transaction(amount, account)
      end
    end

    def insufficient_funds_in_account?(amount, account)
      amount > account.balance
    end

    def perform_transaction(amount, account)
      @funds -= amount
      account.balance = account.balance - amount
      {status: true, message: 'success', date: Date.today, amount: amount}
    end

    def insufficient_funds_in_atm?(amount)
      @funds < amount
    end

    private

    def incorrect_pin?(pin_code, actual_pin)
      pin_code != actual_pin
    end
end
