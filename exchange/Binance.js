.pragma library
.import "../util/Http.js" as Http


function baseUrl() {
    return 'https://api.binance.com/api'
}

function list(callback) {
    let url = baseUrl() + '/v3/ticker/price'

    Http.get(url, {}, function(list) {
        callback(list.map(
            function(l) { return clarify(l.symbol) }
        ))
    })
}

function ticker(symbol, callback) {
    let url = baseUrl() + '/v1/ticker/24hr'
    let params = { symbol: symbol.replace('/', '') }

    Http.get(url, params, function(t) {
        callback({
            symbol: t.symbol,
            price: t.lastPrice,
            change: t.priceChangePercent,
            high: t.highPrice,
            low: t.lowPrice,
            volume: t.volume,
            count: t.count
        })
    })
}

function toUSDT(pair) {
    /* vérifier si symbol.endsWith(BNB|BTC|ETH|USDT)
      pour déterminer la paire \*\/USDT correspondante
      puis faire la conversion
      fonction partagée avec clarify() ?
    */
}

/**
  Transform ETHUSDT to ETH/USDT
*/
function clarify(symbol) {
    let basicCurrencies = ['BTC', 'ETH', 'BNB', 'USDT']

    for (var currency in basicCurrencies)
        if (symbol.endsWith(currency))
            return symbol.replace(currency, '/' + currency)
}
