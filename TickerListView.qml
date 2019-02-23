import QtQuick 2.11
import QtQuick.Controls 2.4
import "component/ticker"
import "component/util"


ListView {
    id: listView
    // drop to remove
    DropArea {
        z: -1
        height: 2
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        onEntered: {
            listView.model.remove(0)
        }
    }

    // double click to create
    MouseArea {
        z: -2
        anchors.fill: parent
        onDoubleClicked: listModel.append({_exchange: '', _symbol: ''})
    }

    model: ListModel {
        id: listModel
    }

    delegate: ReorderDelegate {
        width: listView.width
        height: 100

        Ticker {
            id: ticker
            width: parent.width
            // visual clue for D&D
            bgColor: held ? 'lightgray' : 'gray'
            opacity: 0.9

            // update delegate only when instantiated
            Component.onCompleted: ticker.update()
        }
        onDoubleClicked: ticker.state = 'Edit'
        onMove: listModel.move(from, to, 1)
    }
}
