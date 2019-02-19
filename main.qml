import QtQuick 2.11
import QtQuick.Controls 2.4

ApplicationWindow {
    id: app
    visible: true
    width: 640
    height: 480
    minimumWidth: width
    maximumWidth: width
    minimumHeight: height
    maximumHeight: height
    title: qsTr("Tabs")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        TickerListView {
        }
    }

    footer: Row {
        spacing: 10
        PageIndicator {
            id: tabBar
            currentIndex: swipeView.currentIndex
            count: swipeView.count
            interactive: true
            anchors.verticalCenter: parent.verticalCenter
        }

        // page buttons near page indicator
        Button {
            contentItem: Text {
                text: '⊗'
                font.pointSize: 14
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: parent.enabled ? 'black' : 'gray'
            }
            enabled: swipeView.count > 1
            onPressAndHold: {
                    swipeView.removeItem(swipeView.currentItem)
            }
            width: 30
            height: 40
        }

        Button {
            contentItem: Text {
                text: '🞤'
                font.pointSize: 14
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            enabled: swipeView.currentItem.model.count > 0
            onClicked: {
                let listView = Qt.createComponent("TickerListView.qml").createObject(swipeView)
                swipeView.insertItem(swipeView.currentIndex + 1, listView)
            }
            width: 30
            height: 40
        }
    }
}
