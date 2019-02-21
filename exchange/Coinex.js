.pragma library
.import "../util/Http.js" as Http
.import "Exchange.js" as Exchange

function baseUrl() {
    return 'https://api.coinex.com'
}

function list(callback) {
    let url = baseUrl() + '/v1/market/list'

    Http.get(url, {}, function(list) {
        if (list.code !== 0)
            return console.error('API error : Coinex - ' + list.code)

        callback(list.data.map(
            function(l) { return clarify(l, true) }
        ))
    })
}

function ticker(symbol, callback) {
    let url = baseUrl() + '/v1/market/ticker'
    let params = { market: clarify(symbol, false) }

    Http.get(url, params, function(ticker) {
        if (ticker.code !== 0)
            return console.error('API fail : Coinex - ' + ticker.code)

        let t = ticker.data.ticker
        callback({
            symbol: symbol,
            price: t.last,
            change: t.last/t.open-1,
            high: t.high,
            low: t.low,
            volume: t.vol
        })
    })
}

function toUSDT() {

}

/**
  @TODO fonction commune avec Binance != currencies
*/
function clarify(symbol, exchangeToProgram) {
    let currencies = ['BTC', 'BCH', 'ETH', 'USDT', 'USDC']
    return Exchange.nullClarify(symbol, exchangeToProgram, currencies)
}
