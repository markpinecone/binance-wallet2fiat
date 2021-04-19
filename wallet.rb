require "binance-ruby"
require 'dotenv'
require "./requests"

Dotenv.load

class Wallet
  def get
    info = Binance::Api.info!
    arr = info[:balances]
    arr.reject! { |hash| !hash[:free].to_d.positive? }
    arr.map { |hash| [hash[:asset], hash[:free]] }
  end
end

def get_value
    wallet = Wallet.new.get
    @total = 0
    wallet.each do |crypto|
        if crypto[0].eql? $currency
            @total += crypto[1].to_f
        else
            value = Price.new.get(crypto[0])
            @total += crypto[1].to_f * value.to_f
        end
    end
    p " #{@total.round(2)}"
end
