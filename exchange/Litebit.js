.pragma library
.import "../util/Http.js" as Http
.import "../util/Error.js" as Error

function baseUrl() {
    return 'https://api.litebit.eu'
}

function list(callback) {
    let url = baseUrl() + '/markets'

    Http.get(url, {}, function(error, list) {
        if (error !== null)
            return callback(error)
        if (list.success !== true)
            return callback(Error.API)

        callback(null, Object.keys(list.result).map(
            function(l) { return clarify(l, true) }
        ))
    })
}

function ticker(symbol, callback) {
    let url = baseUrl() + '/market/' + clarify(symbol, false)

    Http.get(url, {}, function(error, ticker) {
        if (error !== null)
            return callback(error)
        if (ticker.success !== true)
            return callback(Error.API)

        let t = ticker.result
        callback(null, {
            symbol: symbol,
            price: t.sell,
            volume: t.volume
        })
    })
}

function toUSDT() {
    // need EUR to USD-T
}

function clarify(symbol, exchangeToProgram) {
    if (exchangeToProgram)
        return symbol.toUpperCase() + '/EUR'
    else
        return symbol.replace(/\/\w+$/, '').toLowerCase()
}
