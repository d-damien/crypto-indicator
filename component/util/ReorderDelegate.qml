import QtQuick 2.0
// @author https://gist.github.com/oKcerG/bd0813e16f48b3316010a1799163b44c


MouseArea {
    id: root

    property Item draggedParent: parent ? parent.parent || parent : null
    property var modelIndex: typeof model !== "undefined" ? model.index : undefined
    signal move(int from, int to)
    property bool dropEnabled: true
    property bool dragEnabled: true

    default property alias contentData: container.data
    readonly property Item contentItem: container.children.length > 0 ? container.children[0] : null

    property bool _held: false
    readonly property alias held: root._held

    // prevent DropArea from waiting drop() forever
    Component.onDestruction: container.Drag.cancel()

    drag {
        target: _held ? container : undefined
        axis: Drag.XandYAxis
        threshold: 0
        minimumX: 0
        maximumX: draggedParent.width - width
        // minimumY: 0
        maximumY: draggedParent.height - height
    }

    onReleased: _held = false
    onCanceled: _held = false
    onPressAndHold: {
        if (dragEnabled)
            _held = true
    }

    Item {
        id: container
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

        width: root.width
        height: root.height
        Drag.active: root._held
        Drag.source: root
        Drag.hotSpot.x: width / 2
        Drag.hotSpot.y: height / 2
        states: State {
            name: "_held"
            when: root._held
            ParentChange {
                target: container
                parent: root.draggedParent
            }
            AnchorChanges {
                target: container
                anchors {
                    horizontalCenter: undefined
                    verticalCenter: undefined
                }
            }
        }
    }

    DropArea {
        id: dropArea
        enabled: dropEnabled
        anchors.fill: parent
        onEntered: {
            if (drag.source.parent !== root.parent || drag.source.modelIndex === root.modelIndex)
                drag.accepted = false
            else
                root.move(drag.source.modelIndex, root.modelIndex)
        }
    }
}
