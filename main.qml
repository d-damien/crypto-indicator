import QtQuick 2.11
import QtQuick.Controls 2.4
import "exchange/Cryptopia.js" as Cryptopia

ApplicationWindow {
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

        Page1Form {
        }

        Page2Form {
            id: page2
            mouseArea {
                onClicked: {
                    Cryptopia.ticker('LTC/BTC', function(o) {
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
