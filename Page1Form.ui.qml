import QtQuick 2.11
import QtQuick.Controls 2.4
import "component/ticker"


Page {
    width: 600
    height: 400

    TickerForm {
        id: ticker
        anchors.right: parent.right
        anchors.left: parent.left
    }
}
