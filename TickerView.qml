import QtQuick 2.11
import QtQuick.Controls 2.4
import "component/ticker"


ListView {
    model: ListModel {
        ListElement {
            _exchange: 'Coinex'
            _symbol: 'IOTA/USDT'
        }
        ListElement {
            _exchange: 'Kucoin'
            _symbol: 'XRP/ETH'
        }
    }

    delegate: Ticker {
        id: ticker
        width: parent.width

        // keep ListView flickable + drag & drop
        property bool held: false
        // visual clue for D&D
        bgColor: held ? 'lightgray' : 'gray'

        MouseArea {
            anchors.fill: parent

            // D&D to reorder tickers
            onPressAndHold: held = true
            onReleased: held = false
            drag.target: held ? parent : null
            drag.axis: Drag.YAxis
        }

        // above other items
        states: State {
            when: held
            PropertyChanges {
                target: ticker
                z: 10
            }
        }
    }
}
