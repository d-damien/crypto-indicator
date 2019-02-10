import QtQuick 2.11
import QtQuick.Controls 2.4

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
    property alias clickToEdit: clickToEdit
    property alias _symbol: _symbol
    property alias _exchange: _exchange
    property alias column: symbolCol

    Rectangle {
        id: rectangle
        color: "#8d8d8d"
        z: -1
        anchors.fill: parent
    }

    MouseArea {
        id: clickToEdit
        anchors.fill: parent
    }

    Row {
        id: row
        anchors.fill: parent

        Column {
            id: symbolCol
            width: parent.width / 4
            topPadding: 20
            spacing: 20

            Text {
                id: _exchange
                text: qsTr("Exchange")
                width: parent.width
                height: 20
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                id: _symbol
                text: qsTr("Symbol")
                width: parent.width
                height: 20
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Column {
            id: priceCol
            width: parent.width / 4
            topPadding: 10

            Text {
                id: _high
                text: qsTr("High")
                width: parent.width
                height: 20
                opacity: 0.9
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                id: _price
                text: qsTr("Price")
                width: parent.width
                height: 40
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                id: _low
                text: qsTr("Low")
                width: parent.width
                height: 20
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Column {
            id: changeCol
            width: parent.width / 4
            topPadding: 20

            Text {
                id: _change
                width: parent.width
                height: 60
                text: qsTr("Change")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Column {
            id: volumeCol
            width: parent.width / 4
            topPadding: 40

            Text {
                id: _volume
                text: qsTr("Volume")
                width: parent.width
                height: 20
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        BusyIndicator {
            id: loadIndicator
            visible: false
            width: 3/4 * parent.width
            height: parent.height
        }
    }

    Row {
        id: editRow
        visible: false
        anchors.fill: parent
        topPadding: 26
        spacing: 13

        ComboBox {
            id: _exchangeComboBox
        }

        ComboBox {
            id: _symbolComboBox
        }

        Switch {
            id: _usdtSwitch
            text: qsTr("Switch")
        }

        Button {
            id: _editOk
            text: qsTr("OK")
        }
    }

    states: [
        State {
            name: "Load"

            PropertyChanges {
                target: priceCol
                visible: false
            }

            PropertyChanges {
                target: changeCol
                visible: false
            }

            PropertyChanges {
                target: volumeCol
                visible: false
            }

            PropertyChanges {
                target: loadIndicator
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
