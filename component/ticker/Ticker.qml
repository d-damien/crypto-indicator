import QtQuick 2.4
import "../../exchange/Binance.js" as Binance
import "../../exchange/Coinex.js" as Coinex
import "../../exchange/Cryptopia.js" as Cryptopia
import "../../exchange/Kucoin.js" as Kucoin
import "../../exchange/Litebit.js" as Litebit
import "../../util/Error.js" as Error

TickerForm {
    property var exchanges: [
        '',
        'Binance',
        'Coinex',
        'Cryptopia',
        'Kucoin',
        'Litebit',
    ]
    property var symbols: []

    // edit logic
    exchangeComboBox {
        onActivated: {
            _exchange = exchangeComboBox.model[index]
            model._exchange = _exchange
            let exchange = eval(_exchange)
            // @todo eval safety
            if (! exchange)
                return

            // @todo loading symbol list
            exchange.list(function(error, l) {
                if (handleError(error))
                    return

                symbols = l
            })
        }

    }

    symbolComboBox {
        onPressedChanged: {
            if (! symbolComboBox.pressed)
                return
            symbolComboBox.model = symbols.filter(
                function(s) { return s.match(symbolComboBox.editText) })
        }

        onActivated: {
            _symbol = symbolComboBox.model[index]
            model._symbol = _symbol
        }
    }

    confirmButton {
        onClicked: {
            if (!_exchange || !_symbol)
                return

            state = ''
            update()
        }
    }


    function update() {
        if (! _exchange || ! _symbol) {
            state = 'Edit'
            return
        }

        state = 'Load'
        // @todo sécurité
        let exchange = eval(_exchange)

        exchange.ticker(_symbol, function(error, t) {
            if (handleError(error))
                return

            _price = t.price || '--'
            _high = t.high || '--'
            _low = t.low || '--'
            _change = t.change || '--'
            _volume = t.volume || '--'

            state = '' // loaded
        })
    }

    // handles error for both list & update
    // returns true if error, false otherwise
    function handleError(error) {
        if (error === null)
            return false

        state = 'Error'
        let text = 'Error: '
        switch (error) {
            case Error.API:
                text += _exchange + ' API'
                break
            case Error.PARSE:
                text += 'JSON parsing'
                break
        }
        errorMsg.text = text
        return true
    }
}
