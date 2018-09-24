.pragma library
.import "../util/Http.js" as Http


function baseUrl() {
    return 'https://api.binance.com/api'
}

function list() {
    let url = baseUrl() + '/v3/ticker/price'
    /*
            [
              {
                "symbol": "ETHBTC",
                "price": "0.03641500"
              },
              {
                "symbol": "LTCBTC",
                "price": "0.00913000"
              },
              ...
            ]
      */

}

function ticker(symbol) {
    let url = baseUrl() + '/v1/ticker/24hr'
    let params = { symbol: symbol }

    /*
        {
          "symbol": "BNBBTC",
          "priceChange": "-94.99999800",
          "priceChangePercent": "-95.960",
          "highPrice": "100.00000000",
          "lowPrice": "0.10000000",
          "volume": "8913.30000000",
          "count": 76
        }
    */
}

function toUSDT(pair) {
    /* vérifier si symbol.endsWith(BNB|BTC|ETH|USDT)
      pour déterminer la paire \*\/USDT correspondante
      puis faire la conversion
    */
}
