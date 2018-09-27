.pragma library
.import "../util/Http.js" as Http

function baseUrl() {
    return 'https://cryptopia.co.nz/api'
}

function list(callback) {
    let url = baseUrl() + '/GetTradePairs'

    Http.get(url, {}, function(list) {
        if (! list.Success)
            return console.error('API error : Cryptopia')

        callback(list.Data.map(
            function(l) { return l.Label }
        ))
    })
}

function ticker(symbol, callback) {
    let url = baseUrl() + '/GetMarket/'
    url += clarify(symbol, false)

    Http.get(url, {}, function(ticker) {
        if (! ticker.Success)
            return console.error('API error : Cryptopia')

        let t = ticker.Data
        callback({
            symbol: t.Label,
            price: t.LastPrice,
            change: t.Change,
            high: t.High,
            low: t.Low,
            volume: t.Volume
        })
    })
}

function clarify(symbol, exchangeToProgram) {
    if (exchangeToProgram)
        return symbol.replace('_', '/')
    else
        return symbol.replace('/', '_')
}
