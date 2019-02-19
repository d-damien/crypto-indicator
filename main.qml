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
        PageIndicator {
            id: tabBar
            currentIndex: swipeView.currentIndex
            count: swipeView.count
            interactive: true
            anchors.verticalCenter: parent.verticalCenter
        }

        // insert page button near page indicator
        Button {
            text: '+'
            enabled: swipeView.currentItem.model.count > 0
            onClicked: {
                let listView = Qt.createComponent("TickerListView.qml").createObject(swipeView)
                swipeView.insertItem(swipeView.currentIndex + 1, listView)
            }
            height: 30
        }
    }
}
