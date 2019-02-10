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
            _exchange.text = combobox
            _symbol.text = t.symbol
            _price.text = t.price
            _high.text = t.high
            _low.text = t.low
            _change.text = t.change
            _volume.text = t.volume

            state = '' // loaded
        })
    }
}
