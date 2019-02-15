import QtQuick 2.11
import QtQuick.Controls 2.4
import "component/ticker"
import "component/util"


ListView {
    id: listView
    model: ListModel {
        id: listModel
        ListElement {
            _exchange: 'Coinex'
            _symbol: 'IOTA/USDT'
        }
        ListElement {
            _exchange: 'Kucoin'
            _symbol: 'XRP/ETH'
        }
        ListElement {
            _exchange: 'Binance'
            _symbol: 'ZIL/BTC'
        }
        ListElement {
            _exchange: 'Litebit'
            _symbol: 'DOGE/EUR'
        }
    }

    delegate: ReorderDelegate {
        width: listView.width
        height: 100

        Ticker {
            width: parent.width
            // visual clue for D&D
             bgColor: held ? 'lightgray' : 'gray'
             opacity: 0.9
        }
        onMove: listModel.move(from, to, 1)
    }
}