.pragma library
.import "../util/Http.js" as Http

function baseUrl() {
    return 'https://api.litebit.eu'
}

function list(callback) {
    let url = baseUrl() + '/markets'

    Http.get(url, {}, function(list) {
        if (! list.success)
            return console.error('API error : Litebit')

        callback(Object.keys(list.result).map(
            function(l) { return clarify(l, true) }
        ))
    })
}

function ticker(symbol, callback) {
    let url = baseUrl() + '/market/' + clarify(symbol, false)

    Http.get(url, {}, function(ticker) {
        if (! ticker.success)
            return console.error('API error : Litebit')

        let t = ticker.result
        callback({
            symbol: symbol,
            price: t.buy + ' / ' + t.sell,
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
