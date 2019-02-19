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

            MouseArea {
                anchors.fill: parent
                propagateComposedEvents: true
                onClicked: mouse.accepted = false
                onDoubleClicked: {
                    // don't stack pages after empty page
                    if (swipeView.currentIndex === swipeView.count-1
                        && ! swipeView.currentItem.model.count)
                        return

                    // add new page
                    let listView = Qt.createComponent("TickerListView.qml").createObject(swipeView)
                    swipeView.insertItem(swipeView.currentIndex + 1, listView)
                }

                onPressAndHold: {
                    // remove page
                    if (swipeView.currentIndex > 0)
                        swipeView.removeItem(swipeView.currentItem)
                }
            }
        }
    }
}
