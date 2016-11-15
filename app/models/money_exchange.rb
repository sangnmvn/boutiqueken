
class MoneyExchange
  def self.exchange(us_price,to_currency)
    # puts us_price
    # puts "============CURRR"
    # puts to_currency
    # Money::Bank::GoogleCurrency.ttl_in_seconds = 86400

    # # set default bank to instance of GoogleCurrency
    # Money.default_bank = Money::Bank::GoogleCurrency.new
    rate = Money.default_bank.get_rate("USD", to_currency.upcase.to_sym)
    # create a new money object, and use the standard #exchange_to method
    money = Money.us_dollar((us_price * 100).to_i) # amount is in cents
    if to_currency.upcase.to_sym != "USD"
      money.exchange_to(to_currency.upcase.to_sym)
    else
      us_price
    end
    
  end

  def self.get_rate(from_c,to_c)
    Money::Bank::GoogleCurrency.ttl_in_seconds = 86400

    # set default bank to instance of GoogleCurrency
    Money.default_bank = Money::Bank::GoogleCurrency.new
    rate = Money.default_bank.get_rate(from_c.upcase.to_sym,to_c.upcase.to_sym)
    Money.default_bank.add_rate("USD", to_c.upcase.to_sym, rate)
    Money.default_bank.get_rate("USD", to_c.upcase.to_sym)
  end


  def self.t_exchange(us_price,to_currency)
    curr = {
      :priority        => 1,
      :iso_code        => "USD",
      :iso_numeric     => "840",
      :name            => "United States Dollar",
      :symbol          => "$",
      :subunit         => "Cent",
      :subunit_to_unit => 100,
      :separator       => ".",
      :delimiter       => ","
    }

    Money::Currency.register(curr)
    rate = Money.default_bank.get_rate("USD", to_currency.upcase.to_sym)
    puts "==========++RATE"
    puts rate
    # create a new money object, and use the standard #exchange_to method
    money = Money.us_dollar(us_price, "USD") # amount is in cents
    money.exchange_to(to_currency.upcase.to_sym)
  end
  # def self.check()
  #     Money.default_bank = Money::Bank::VariableExchange.new(StoreWhichScrapesXeDotCom.new)
  # end
end