import QtQuick 2.4
import QtQuick.Controls 2.3

Item {
    width: 400
    height: 100
    property alias _editOk: _editOk
    property alias _usdtSwitch: _usdtSwitch
    property alias _symbolComboBox: _symbolComboBox
    property alias _exchangeComboBox: _exchangeComboBox
    property alias _volume: _volume
    property alias _change: _change
    property alias _low: _low
    property alias _price: _price
    property alias _high: _high
    property alias _editMouseArea: _editMouseArea
    property alias _symbol: _symbol
    property alias _exchange: _exchange
    property alias column: column

    Rectangle {
        id: rectangle
        color: "#8d8d8d"
        z: -1
        anchors.fill: parent
    }

    Row {
        id: row
        anchors.fill: parent

        Column {
            id: column
            width: parent.width / 4
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.top: parent.top

            Text {
                id: _exchange
                height: 20
                text: qsTr("Exchange")
                anchors.top: parent.top
                anchors.topMargin: 20
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                font.pixelSize: 12
            }

            Text {
                id: _symbol
                height: 20
                text: qsTr("Symbol")
                anchors.top: _exchange.bottom
                anchors.topMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 0
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                anchors.rightMargin: 0
            }

            MouseArea {
                id: _editMouseArea
                anchors.fill: parent
            }
        }

        Column {
            id: column1
            width: parent.width / 4
            anchors.leftMargin: 0
            anchors.left: column.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            Text {
                id: _high
                height: 20
                text: qsTr("High")
                opacity: 0.9
                anchors.left: parent.left
                anchors.leftMargin: 0
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
                anchors.top: parent.top
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                anchors.topMargin: 10
                anchors.rightMargin: 0
            }

            Text {
                id: _price
                height: 40
                text: qsTr("Price")
                anchors.left: parent.left
                anchors.leftMargin: 0
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
                anchors.top: _high.bottom
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                anchors.topMargin: 0
                anchors.rightMargin: 0
            }

            Text {
                id: _low
                height: 20
                text: qsTr("Low")
                anchors.left: parent.left
                anchors.leftMargin: 0
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
                anchors.top: _price.bottom
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                anchors.topMargin: 0
                anchors.rightMargin: 0
            }
        }

        Column {
            id: column2
            width: parent.width / 4
            anchors.leftMargin: 0
            anchors.left: column1.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            Text {
                id: _change
                width: 101
                height: 60
                text: qsTr("Change")
                anchors.left: parent.left
                anchors.leftMargin: 0
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                anchors.top: parent.top
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                anchors.topMargin: 20
                anchors.rightMargin: 0
            }
        }

        Column {
            id: column3
            width: parent.width / 4
            anchors.leftMargin: 0
            anchors.left: column2.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            Text {
                id: _volume
                height: 20
                text: qsTr("Volume")
                anchors.left: parent.left
                anchors.leftMargin: 0
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                anchors.top: parent.top
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                anchors.topMargin: 40
                anchors.rightMargin: 0
            }
        }

        BusyIndicator {
            id: _loadIndicator
            anchors.fill: parent
            visible: false
        }
    }

    Row {
        id: editRow
        visible: false
        anchors.fill: parent

        Column {
            id: column4
            width: parent.width / parent.children.length
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.top: parent.top

            ComboBox {
                id: _exchangeComboBox
                anchors.top: parent.top
                anchors.topMargin: 26
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 13
            }
        }

        Column {
            id: column5
            width: parent.width / parent.children.length
            anchors.leftMargin: 0
            anchors.left: column4.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            ComboBox {
                id: _symbolComboBox
                anchors.top: parent.top
                anchors.topMargin: 26
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.left: parent.left
                anchors.leftMargin: 0
            }
        }

        Column {
            id: column6
            width: parent.width / parent.children.length
            anchors.leftMargin: 0
            anchors.left: column5.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            Switch {
                id: _usdtSwitch
                text: qsTr("Switch")
                anchors.top: parent.top
                anchors.topMargin: 26
                anchors.right: parent.right
                anchors.rightMargin: 29
                anchors.left: parent.left
                anchors.leftMargin: 0
            }
        }

        Column {
            id: column7
            width: parent.width / parent.children.length
            anchors.top: parent.top
            anchors.left: column6.right
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom

            Button {
                id: _editOk
                text: qsTr("OK")
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
    states: [
        State {
            name: "Load"

            PropertyChanges {
                target: column1
                visible: false
            }

            PropertyChanges {
                target: column2
                visible: false
            }

            PropertyChanges {
                target: column3
                visible: false
            }

            PropertyChanges {
                target: _loadIndicator
                anchors.leftMargin: 100
                visible: true
            }
        },
        State {
            name: "Edit"

            PropertyChanges {
                target: row
                visible: false
            }

            PropertyChanges {
                target: editRow
                visible: true
            }
        }
    ]
}

/*##^## Designer {
    D{i:3;anchors_height:400;anchors_width:200;anchors_x:69;anchors_y:26}D{i:5;anchors_height:400;anchors_width:200}
D{i:1;anchors_height:200;anchors_width:200;anchors_x:100;anchors_y:30}D{i:7;anchors_height:400;anchors_width:200}
D{i:6;anchors_height:400;anchors_width:200}
}
 ##^##*/
