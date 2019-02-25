import QtQuick 2.11
import QtQuick.Controls 2.4
import Qt.labs.settings 1.0

ApplicationWindow {
    id: app
    visible: true
    width: 400
    height: 480
    minimumWidth: width
    maximumWidth: width
    minimumHeight: height
    maximumHeight: height
    title: qsTr("Tabs")

    // restore & save data
    property string tickerList: "[[]]"
    Settings {
        category: 'Ticker'
        property alias list: app.tickerList
    }

    onClosing: {
        // serialize tickers lists
        let tickerLists = [], children = swipeView.contentChildren
        for (var i=0; i < children.length; i++) {
            let tickers = []
            for (var j=0; j < children[i].model.count; j++) {
                tickers.push(children[i].model.get(j))
            }
            tickerLists.push(tickers)
        }
        app.tickerList = JSON.stringify(tickerLists)
    }

    Component.onCompleted: {
        // restore tickers lists
        // @todo catch parse errors
        let tickerLists = JSON.parse(app.tickerList)
        tickerLists.forEach(function(tickers) {
            let listView = newListView()
            tickers.forEach(function(t) {
                listView.model.append(t)
            })
            swipeView.addItem(listView)
        })
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
    }

    function newListView() {
        return Qt.createComponent("TickerListView.qml").createObject(swipeView)
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
            // enabled: swipeView.currentItem && swipeView.currentItem.model.count > 0
            onClicked: {
                let listView = newListView()
                swipeView.insertItem(swipeView.currentIndex + 1, listView)
            }
            width: 30
            height: 40
        }
    }
}
