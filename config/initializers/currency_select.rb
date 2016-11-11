# module CurrencySelect
#   class << self

#     CURRENCIES = Money::Currency::table.inject([]) do |array, (id, currency)|
#         array << [ "#{currency[:name]}", id ]
#     end.sort_by { |currency| currency.first }.uniq
#   end
# end

module CurrencySelect
  class << self

    
    # Return an array with ISO codes and currency names for currency ISO codes
    # passed as an argument
    # == Example
    #   priority_currencies_array([ "USD", "NOK" ])
    #   # => [ ['United States Dollar - USD', 'USD' ], ['Norwegian Kroner - NOK', 'NOK'] ]
    def priority_currencies_array(currency_codes = [])
      currency_codes.flat_map { |code| currencies_array.select { |currency| currency.last.to_s == code }}
    end

  end
end