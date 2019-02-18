import QtQuick 2.11
import QtQuick.Controls 2.4
import "component/ticker"
import "component/util"


ListView {
    id: listView
    // drop to remove
    DropArea {
        z: -1
        height: 2
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        onEntered: {
            listView.model.remove(0)
        }
    }

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
            id: ticker
            width: parent.width
            // visual clue for D&D
             bgColor: held ? 'lightgray' : 'gray'
             opacity: 0.9
        }
        onDoubleClicked: ticker.state = 'Edit'
        onMove: listModel.move(from, to, 1)
    }
}
