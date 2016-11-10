
class MoneyExchange
  def self.exchange(us_price,to_currency)
    # puts us_price
    # puts "============CURRR"
    # puts to_currency
    # Money::Bank::GoogleCurrency.ttl_in_seconds = 86400

    # # set default bank to instance of GoogleCurrency
    # Money.default_bank = Money::Bank::GoogleCurrency.new
    Money.default_bank.get_rate("USD", to_currency.upcase.to_sym)
    # create a new money object, and use the standard #exchange_to method
    money = Money.new(us_price * 100, "USD") # amount is in cents
    money.exchange_to(to_currency.upcase.to_sym)
    
  end

  def self.get_rate(from_c,to_c)
    Money::Bank::GoogleCurrency.ttl_in_seconds = 86400

    # set default bank to instance of GoogleCurrency
    Money.default_bank = Money::Bank::GoogleCurrency.new
    rate = Money.default_bank.get_rate(from_c.upcase.to_sym,to_c.upcase.to_sym)
    Money.default_bank.add_rate("USD", to_c.upcase.to_sym, rate)
    Money.default_bank.get_rate("USD", to_c.upcase.to_sym)
  end

  # def self.check()
  #     Money.default_bank = Money::Bank::VariableExchange.new(StoreWhichScrapesXeDotCom.new)
  # end
end