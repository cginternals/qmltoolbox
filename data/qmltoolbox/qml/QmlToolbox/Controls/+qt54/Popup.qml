
import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2

Item 
{
    id: root

    default property alias content: popupContent.data

    property var closePolicy

    property alias bottomPadding: popup.bottomPadding
    property alias leftPadding: popup.leftPadding
    property alias rightPadding: popup.rightPadding
    property alias topPadding: popup.topPadding
    property alias padding: popup.padding

    readonly property Item popupItem: Pane {
        id: popup

        visible: false
        z: 100

        width: root.width
        height: root.height

        Item {
            id: popupContent

            anchors.fill: parent
        }
    }

    signal closed()
    signal opened()

    function close() {
        popup.visible = false;
        closed();
    }

    function open() {
        popup.visible = true;
        opened();
    }

    visible: false
    z: -1000

    Component.onCompleted: {
        privateItem.parentItem = root.parent;
    }

    Window.onContentItemChanged: {
        if (Window.contentItem !== null) {
            root.parent = Window.contentItem;
            popup.parent = Window.contentItem;

            popup.x = Qt.binding(function() { return root.parent.mapFromItem(privateItem.parentItem, root.x, root.y).x; });
            popup.y = Qt.binding(function() { return root.parent.mapFromItem(privateItem.parentItem, root.x, root.y).y; });
        }
    }

    QtObject {
        id: privateItem

        property Item parentItem
    }
}
