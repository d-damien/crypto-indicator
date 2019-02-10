import QtQuick 2.11
import QtQuick.Controls 2.4
import "component/ticker"


Page {
    property alias triggerUpdateClick: triggerUpdateClick
    property alias ticker: ticker

    Ticker {
        id: ticker
        anchors.right: parent.right
        anchors.left: parent.left
    }

    Text {
        id: text1
        text: qsTr("Cliquez-moi")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        MouseArea {
            id: triggerUpdateClick
            anchors.fill: parent
        }
    }
}
