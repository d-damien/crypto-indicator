import QtQuick 2.4
import QtQuick.Window 2.3
import "../../exchange/Binance.js" as Binance
import "../../exchange/Coinex.js" as Coinex
import "../../exchange/Cryptopia.js" as Cryptopia
import "../../exchange/Kucoin.js" as Kucoin
import "../../exchange/Litebit.js" as Litebit
import "../../util/Error.js" as Error
import "../../util/Num.js" as Num

TickerForm {
    function exchanges() {
        return Object.keys(_exchanges)
    }

    property var _exchanges: {
        '': '',
        Binance: '#F5BC00',
        Coinex: '#12D5C2',
        Cryptopia: '#16BD7D',
        Kucoin: '#127EFF',
        Litebit: '#2480C3',
    }
    property var symbols: []

    // edit logic
    exchangeComboBox {
        model: exchanges()
        onActivated: {
            _exchange = exchangeComboBox.model[index]
            model._exchange = _exchange
            let exchange = fromString(_exchange)
            if (! exchange) return

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


    Timer {
        id: timer
        interval: 300000
        running: app.visible === true
        repeat: true
        onTriggered: update()
    }

    function update() {
        if (! _exchange || ! _symbol) {
            state = 'Edit'
            return
        }

        let exchange = fromString(_exchange)
        if (! exchange) return

        state = 'Load'
        exchange.ticker(_symbol, function(error, t) {
            if (handleError(error))
                return

            _price = Num.precise(t.price) || t.price || '--'
            _high = Num.precise(t.high) || '--'
            _low = Num.precise(t.low) || '--'
            _change = Num.percent(t.change) || '--'
            _volume = Num.precise(t.volume) || '--'

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

    // Safely change string to exchange class.
    // Using eval to avoid long switch()es.
    function fromString(exchangeName) {
        if (exchanges().indexOf(exchangeName) === -1 || ! exchangeName)
            return null
        return eval(exchangeName)
    }

}
