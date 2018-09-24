import QtQuick 2.11
import QtQuick.Controls 2.4
import "util/Http.js" as Http

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Tabs")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1Form {
        }

        Page2Form {
            id: page2
            mouseArea {
                onClicked: {
                    Http.get(0, {}, function(o) {
                        text.text = 'value ' + o.symbol + ' ' + o.price
                    })
                }
            }
        }
    }

    footer: PageIndicator {
        id: tabBar
        currentIndex: swipeView.currentIndex
        count: swipeView.count
        interactive: true
    }
}
