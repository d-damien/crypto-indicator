import QtQuick 2.11
import QtQuick.Controls 2.4

Page {
    id: page
    width: 600
    height: 400
    // contentHeight: 2
    // contentWidth: -1
    property alias mouseArea: mouseArea
    property alias topLeftRect: topLeftRect
    property alias text: t

    header: Label {
        text: qsTr("Page 2")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Text {
        id: t
        text: '<a href="http://google.com">test</a>'

        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: -19
        anchors.centerIn: parent
    }

    Rectangle {
        id: topLeftRect
        width: 100
        height: 100
        color: "#00000000"
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 20
        border.width: 2
        border.color: "#808080"

        MouseArea {
            id: mouseArea
            anchors.fill: parent
        }
    }
}
