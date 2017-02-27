
import QtQuick 2.4
import QtQuick.Window 2.2


/**
*  Popup
*
*  Implementation of Popup using QtQuick 2.4
*
*  This is a work in progress. Todos:
*  - (x, y) coordinates are currently in the window's 
*    coordinate system but should be in the popup's parent's
*  - close policies are yet to be added, especially to close
*    the popup when the mouse is clicked outside of it 
*    (could be done with a transparent item spanning the whole window)  
*/
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

    readonly property Item popupItem: Pane 
    {
        id: popup

        visible: false
        z: 100

        background: Rectangle
        {
            border { color: "black"; width: 1 }
        }

        width: root.width
        height: root.height

        Item 
        {
            id: popupContent

            anchors.fill: parent
        }
    }

    signal closed()
    signal opened()

    function close() 
    {
        popup.visible = false;
        closed();
    }

    function open() 
    {
        popup.visible = true;
        opened();
    }

    visible: false
    z: -1000

    Component.onCompleted: 
    {
        privateItem.parentItem = root.parent;
    }

    Window.onContentItemChanged: 
    {
        if (Window.contentItem !== null) 
        {
            root.parent = Window.contentItem;
            popup.parent = Window.contentItem;

            /**
             * TODO: Unfortunately, this doesn't work. Possible explanation:
             * If parent is an ancestor of a item that hasn't been added 
             * to the item hierarchy yet, mapFromItem() fails. This is for example
             * the case for the contentItem in Control.qml.
             */
            popup.x = Qt.binding(function() { return root.parent.mapFromItem(privateItem.parentItem, root.x, root.y).x; });
            popup.y = Qt.binding(function() { return root.parent.mapFromItem(privateItem.parentItem, root.x, root.y).y; });
        }
    }

    QtObject 
    {
        id: privateItem

        property Item parentItem
    }
}
