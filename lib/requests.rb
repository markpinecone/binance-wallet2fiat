
require "httparty"

$currency = "USDT"

class BinanceRequests
  include HTTParty
  base_uri 'api.binance.com'

  # creates trading pair uri for request
  def symbols(symbol)
    self.class.get("/api/v3/ticker/price?symbol=#{symbol}#{$currency}")
  end

  def get_price(symbol)
    request = symbols(symbol).to_a
    request[1][1]
  end
end