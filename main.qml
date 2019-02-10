import QtQuick 2.11
import QtQuick.Controls 2.4
import "exchange/Cryptopia.js" as Cryptopia

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

        TickerView {
        }

        Page2Form {
        }
    }

    footer: PageIndicator {
        id: tabBar
        currentIndex: swipeView.currentIndex
        count: swipeView.count
        interactive: true
    }
}
