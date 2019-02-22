.pragma library
.import "../util/Http.js" as Http
.import "../util/Error.js" as Error

function baseUrl() {
    return 'https://cryptopia.co.nz/api'
}

function list(callback) {
    let url = baseUrl() + '/GetTradePairs'

    Http.get(url, {}, function(error, list) {
        if (error !== null)
            return callback(error)
        if (! list.Success)
            return callback(Error.API)

        callback(null, list.Data.map(
            function(l) { return l.Label }
        ))
    })
}

function ticker(symbol, callback) {
    let url = baseUrl() + '/GetMarket/'
    url += clarify(symbol, false)

    Http.get(url, {}, function(error, ticker) {
        if (error !== null)
            return callback(error)
        if (! ticker.Success)
            return callback(Error.API)

        let t = ticker.Data
        callback(null, {
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
