.pragma library
.import "../util/Http.js" as Http

function baseUrl() {
    return 'https://api.kucoin.com'
}

function list(callback) {
    let url = baseUrl() + '/v1/open/tick'

    Http.get(url, {}, function(list) {
        if (list.code !== 'OK')
            return console.error('API failed : Kucoin')

        callback(list.data.map(
            function(l) { return clarify(l.symbol, true) }
        ))
    })
}

function ticker(symbol, callback) {
    let url = baseUrl() + '/v1/open/tick'
    let params = { symbol: clarify(symbol, false) }

    Http.get(url, params, function(ticker) {
        if (ticker.code !== 'OK')
            return console.error('API failed : Kucoin')

        let t = ticker.data
        callback({
            symbol: clarify(t.symbol, true),
            price: t.lastDealPrice,
            change: t.change,
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
