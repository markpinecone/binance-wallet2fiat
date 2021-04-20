require "binance-ruby"
require 'dotenv'
require "./lib/requests"

Dotenv.load

class Wallet
  def self.get_ballance
    info = Binance::Api.info!
    arr = info[:balances]
    arr.reject! { |hash| !hash[:free].to_d.positive? }
    arr.map { |hash| [hash[:asset], hash[:free]] }
  end

  def self.get_value
      @total = 0
      self.get_ballance.each do |crypto|
          if crypto[0].eql? $currency
              @total += crypto[1].to_f
          else
              value = BinanceRequests.new.get_price(crypto[0])
              @total += crypto[1].to_f * value.to_f
          end
      end
      p " #{@total.round(2)}"
  end
end

