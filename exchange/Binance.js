.pragma library
.import "../util/Http.js" as Http


function baseUrl() {
    return 'https://api.binance.com/api'
}

function list(callback) {
    let url = baseUrl() + '/v3/ticker/price'

    Http.get(url, {}, function(list) {
        callback(list.map(
            function(l) { return clarify(l.symbol, true) }
        ))
    })
}

function ticker(symbol, callback) {
    let url = baseUrl() + '/v1/ticker/24hr'
    let params = { symbol: clarify(symbol, false) }

    Http.get(url, params, function(t) {
        callback({
            symbol: clarify(t.symbol, true),
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
  Translate ETHUSDT <-> ETH/USDT
*/
function clarify(symbol, exchangeToProgram) {
    if (exchangeToProgram) {
        let currencies = ['BTC', 'ETH', 'BNB', 'USDT']
        for (var c in currencies)
            if (symbol.endsWith(currencies[c]))
                return symbol.replace(currencies[c], '/' + currencies[c])
    } else {
        return symbol.replace('/', '')
    }
}
