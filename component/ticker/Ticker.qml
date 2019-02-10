import QtQuick 2.4
import "../../exchange/Binance.js" as Binance
import "../../exchange/Coinex.js" as Coinex
import "../../exchange/Cryptopia.js" as Cryptopia
import "../../exchange/Kucoin.js" as Kucoin
import "../../exchange/Litebit.js" as Litebit

TickerForm {
    /*
    _editMouseArea {
        onDoubleClicked: state = 'Edit'
        // ... ?
    }

    _editOk {
        onClicked: {
            state = ''
            // ...
        }
    }
    */

    function update() {
        state = 'Load'
        // todo
        let combobox = 'Binance'
        let symbol = 'IOTA/USDT'

        let exchange = eval(combobox)

        exchange.ticker(symbol, function(t) {
            _price = t.price
            _high = t.high
            _low = t.low
            _change = t.change
            _volume = t.volume

            state = '' // loaded
        })
    }
}
