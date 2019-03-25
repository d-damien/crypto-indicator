import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3

Item {
    width: 400
    height: 100
    property string _high: _high
    property string _price: _price
    property string _low: _low
    property string _change: _change
    property string _volume: _volume

    property alias exchangeComboBox: exchangeComboBox
    property alias symbolComboBox: symbolComboBox
    // property alias usdtSwitch: usdtSwitch
    property alias confirmButton: confirmButton
    property alias changeLabel: changeLabel
    property alias errorMsg: errorMsg

    // change bg dynamically (e.g. drag & drop)
    property alias bgColor: background.color


    Rectangle {
        id: background
        anchors.fill: parent
        color: Material.background
        z: -1
        border.width: 2
        border.color: 'grey'
        radius: 10
    }

    Row {
        id: displayRow
        anchors.fill: parent

        Column {
            id: symbolCol
            width: parent.width / 4
            topPadding: 20
            spacing: 20

            Label {
                text: _exchange || qsTr("[Exchange]")
                width: parent.width
                height: 20
                font.family: 'Ubuntu Condensed'
                font.pointSize: 15
                font.bold: true
                color: _exchanges[_exchange]
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                text: _symbol || qsTr("[Symbol]")
                width: parent.width
                height: 20
                font.bold: true
                color: _exchanges[_exchange]
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Row {
            id: infoRow
            width: 3/4 * parent.width
            height: parent.height

            Column {
                id: priceCol
                width: parent.width / 3
                topPadding: 10

                Label {
                    text: _high || qsTr("[High]")
                    width: parent.width
                    height: 20
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                Label {
                    text: _price || qsTr("[Price]")
                    font.pixelSize: 20
                    color: '#fbfbfb'
                    width: parent.width
                    height: 40
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                Label {
                    text: _low || qsTr("[Low]")
                    width: parent.width
                    height: 20
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Column {
                id: changeCol
                width: parent.width / 3
                topPadding: 20

                Label {
                    id: changeLabel
                    text: _change || qsTr("[Change]")
                    color: _change > 0 ? '#0E9D0E' : 'red'
                    font.pixelSize: 20
                    font.bold: true
                    width: parent.width
                    height: 60
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Column {
                id: volumeCol
                width: parent.width / 3
                topPadding: 40

                Label {
                    text: _volume || qsTr("[Volume]")
                    width: parent.width
                    height: 20
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

        BusyIndicator {
            id: loadIndicator
            visible: false
            width: 3/4 * parent.width
            height: parent.height
        }

        Label {
            id: errorMsg
            visible: false
            text: 'Error...'
            width: 3/4 * parent.width
            height: parent.height
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

    }

    Row {
        id: editRow
        visible: false
        anchors.fill: parent
        topPadding: 26
        leftPadding: 20
        spacing: 20

        ComboBox {
            id: exchangeComboBox
        }

        ComboBox {
            id: symbolComboBox
            editable: true
        }

//        Switch {
//            id: usdtSwitch
//            text: qsTr("Switch")
//        }

        Button {
            id: confirmButton
            text: qsTr("OK")
        }
    }

    states: [
        State {
            name: "Edit"

            PropertyChanges {
                target: displayRow
                visible: false
            }

            PropertyChanges {
                target: editRow
                visible: true
            }
        },
        State {
            name: "Load"

            PropertyChanges {
                target: infoRow
                visible: false
            }

            PropertyChanges {
                target: loadIndicator
                visible: true
            }
        },
        State {
            name: "Error"

            PropertyChanges {
                target: infoRow
                visible: false
            }

            PropertyChanges {
                target: errorMsg
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
