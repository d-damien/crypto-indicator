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
        width: parent.width
    }
}
