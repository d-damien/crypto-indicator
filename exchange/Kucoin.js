.pragma library
.import "../util/Http.js" as Http

function baseUrl() {
    return 'https://api.kucoin.com/api'
}

function list(callback) {
    let url = baseUrl() + '/v1/symbols'

    Http.get(url, {}, function(list) {
        if (list.code !== '200000') // sic
            return console.error('API failed : Kucoin')

        callback(list.data.map(
            function(l) { return clarify(l.symbol, true) }
        ))
    })
}

function ticker(symbol, callback) {
    let url = baseUrl() + '/v1/market/stats'
    let params = { symbol: clarify(symbol, false) }

    Http.get(url, params, function(ticker) {
        if (ticker.code !== '200000')
            return console.error('API failed : Kucoin')

        let t = ticker.data
        callback({
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
