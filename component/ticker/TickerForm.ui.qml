import QtQuick 2.11
import QtQuick.Controls 2.4

Item {
    width: 400
    height: 100
    property string _high: _high
    property string _price: _price
    property string _low: _low
    property string _change: _change
    property string _volume: _volume

    property alias exchangeComboBox: exchangeComboBox
    property alias _symbolComboBox: _symbolComboBox
    property alias usdtSwitch: usdtSwitch
    property alias confirm: confirm

    // change bg dynamically (e.g. drag & drop)
    property string bgColor: bgColor

    Rectangle {
        id: background
        anchors.fill: parent
        color: bgColor || "#8d8d8d"
        z: -1
    }

    Row {
        id: displayRow
        anchors.fill: parent

        Column {
            id: symbolCol
            width: parent.width / 4
            topPadding: 20
            spacing: 20

            Text {
                text: _exchange || qsTr("[Exchange]")
                width: parent.width
                height: 20
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                text: _symbol || qsTr("[Symbol]")
                width: parent.width
                height: 20
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

                Text {
                    text: _high || qsTr("[High]")
                    width: parent.width
                    height: 20
                    opacity: 0.9
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    text: _price || qsTr("[Price]")
                    width: parent.width
                    height: 40
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
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

                Text {
                    text: _change || qsTr("[Change]")
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

                Text {
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
    }

    Row {
        id: editRow
        visible: false
        anchors.fill: parent
        topPadding: 26
        spacing: 13

        ComboBox {
            id: exchangeComboBox
        }

        ComboBox {
            id: _symbolComboBox
        }

        Switch {
            id: usdtSwitch
            text: qsTr("Switch")
        }

        Button {
            id: confirm
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
        }
    ]
}

/*##^## Designer {
    D{i:3;anchors_height:400;anchors_width:200;anchors_x:69;anchors_y:26}D{i:5;anchors_height:400;anchors_width:200}
D{i:1;anchors_height:200;anchors_width:200;anchors_x:100;anchors_y:30}D{i:7;anchors_height:400;anchors_width:200}
D{i:6;anchors_height:400;anchors_width:200}
}
 ##^##*/
