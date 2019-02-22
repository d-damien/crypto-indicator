.pragma library
.import "../util/Http.js" as Http
.import "../util/Error.js" as Error

function baseUrl() {
    return 'https://api.kucoin.com/api'
}

function list(callback) {
    let url = baseUrl() + '/v1/symbols'

    Http.get(url, {}, function(error, list) {
        if (error !== null)
            return callback(error)
        if (list.code !== '200000') // sic
            return callback(Error.API)

        callback(null, list.data.map(
            function(l) { return clarify(l.symbol, true) }
        ))
    })
}

function ticker(symbol, callback) {
    let url = baseUrl() + '/v1/market/stats'
    let params = { symbol: clarify(symbol, false) }

    Http.get(url, params, function(error, ticker) {
        if (error !== null)
            return callback(error)
        if (ticker.code !== '200000')
            return callback(Error.API)

        let t = ticker.data
        callback(null, {
            price: t.last,
            change: t.changeRate,
            high: t.high,
            low: t.low,
            volume: t.vol
        })
    })
}

function toUSDT() {
}

/**
  Translate ETH-USDT to ETH/USDT
*/
function clarify(symbol, exchangeToProgram) {
    if (exchangeToProgram)
        return symbol.replace('-', '/')
    else
        return symbol.replace('/', '-')
}
