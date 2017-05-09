
import QtQuick 2.4
import QtQuick.Window 2.2


/**
*  Popup
*
*  Base type of popup-like user interface controls
*
*  Implementation of Popup using QtQuick 2.4
*/
QtObject
{
    id: root

    signal opened()
    signal closed()

    property Item parent: window.contentItem

    property alias x:             popup.x
    property alias y:             popup.y
    property alias z:             popup.z
    property alias width:         popup.width
    property alias height:        popup.height
    property alias padding:       popup.padding
    property alias leftPadding:   popup.leftPadding
    property alias rightPadding:  popup.rightPadding
    property alias topPadding:    popup.topPadding
    property alias bottomPadding: popup.bottomPadding

    property var closePolicy: 0

    default property alias data: popup.data

    readonly property Item popupItem: Pane
    {
        id: popup

        parent: root.parent

        visible: false
        z:       100

        background: Rectangle
        {
            border.color: 'black'
            border.width: 1
        }
    }

    function open()
    {
        popup.visible = true;
        opened();
    }

    function close()
    {
        popup.visible = false;
        closed();
    }
}
