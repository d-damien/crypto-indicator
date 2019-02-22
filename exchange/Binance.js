.pragma library
.import "../util/Http.js" as Http
.import "../util/Error.js" as Error
.import "Exchange.js" as Exchange


function baseUrl() {
    return 'https://api.binance.com/api'
}

function list(callback) {
    let url = baseUrl() + '/v3/ticker/price'

    Http.get(url, {}, function(error, list) {
        if (error !== null)
            return callback(error)
        if (list.code)
            return callback(Error.API)

        callback(null, list.map(
            function(l) { return clarify(l.symbol, true) }
        ))
    })
}

function ticker(symbol, callback) {
    let url = baseUrl() + '/v1/ticker/24hr'
    let params = { symbol: clarify(symbol, false) }

    Http.get(url, params, function(error, t) {
        if (error !== null)
            return callback(error)
        if (t.code)
            return callback(Error.API)

        callback(null, {
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
    let currencies = [
        'BNB',
        'BTC',
        'ETH',
        'XRP',
        'USDT',
        'TUSD',
        'PAX',
        'USDC',
        'USDS'
    ]
    return Exchange.nullClarify(symbol, exchangeToProgram, currencies)
}
