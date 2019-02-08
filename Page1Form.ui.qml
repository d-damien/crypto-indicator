import QtQuick 2.11
import QtQuick.Controls 2.4
import "component/ticker"


Page {
    width: 600
    height: 400

    header: Label {
        text: qsTr("Page 1")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    TickerForm {
        id: ticker
        anchors.right: parent.right
        anchors.left: parent.left
    }

    Label {
        text: qsTr("You are on Page 1.")
        anchors.centerIn: parent
    }
}
