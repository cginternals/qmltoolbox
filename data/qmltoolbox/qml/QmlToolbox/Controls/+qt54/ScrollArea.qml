
import QtQuick 2.0
import QtQuick.Controls 1.1

import QmlToolbox.Base 1.0


/**
*  ScrollArea
*
*  Item with scrollable content and scroll bars
*/
Item
{
    id: item

    default property alias data: flickable.flickableData

    property alias contentWidth:       flickable.contentWidth
    property alias contentHeight:      flickable.contentHeight
    property alias contentX:           flickable.contentX
    property alias contentY:           flickable.contentY
    property alias flickableDirection: flickable.flickableDirection
    property alias boundsBehavior:     flickable.boundsBehavior

    Item
    {
        id: scrollBar

        anchors.right:   parent.right
        anchors.top:     parent.top
        anchors.bottom:  parent.bottom
        anchors.margins: Ui.style.tinyPadding
        width:           Ui.style.scrollBarSize

        visible: flickable.contentHeight > flickable.height

        readonly property bool hovered: mouseArea.containsMouse
        readonly property bool pressed: typeof(mouseArea.containsPress) != 'undefined' ? mouseArea.containsPress : false

        Rectangle
        {
            id: handle

            anchors.left:    parent.left
            anchors.right:   parent.right
            anchors.margins: Ui.style.tinyPadding
            height:          Math.max(30, Math.min(flickable.height / flickable.contentHeight, 1.0) * scrollBar.height)

            y: mouseArea.drag.active ? 0 : (flickable.contentY / (flickable.contentHeight - flickable.height)) * (scrollBar.height - handle.height)

            color:  scrollBar.hovered ? Ui.style.controlColorHovered : Ui.style.controlColor
            radius: Ui.style.scrollBarRadius

            MouseArea
            {
                id: mouseArea

                anchors.fill: parent

                drag.target:   handle
                drag.minimumY: 0
                drag.maximumY: scrollBar.height - handle.height

                hoverEnabled: true
            }

            onYChanged:
            {
                if (mouseArea.drag.active)
                {
                    flickable.contentY = Math.max(0, (y / (scrollBar.height - handle.height)) * (flickable.contentHeight - flickable.height));
                }
            }
        }

        MouseArea
        {
            anchors.left:   parent.left
            anchors.right:  parent.right
            anchors.top:    parent.top
            anchors.bottom: handle.top

            onClicked:
            {
                flickable.contentY = Math.max(0, flickable.contentY - flickable.height);
            }
        }

        MouseArea
        {
            anchors.left:   parent.left
            anchors.right:  parent.right
            anchors.top:    handle.bottom
            anchors.bottom: parent.bottom

            onClicked:
            {
                flickable.contentY = Math.min(flickable.contentHeight - flickable.height, flickable.contentY + flickable.height);
            }
        }
    }

    Flickable
    {
        id: flickable

        anchors.left:    parent.left
        anchors.right:   scrollBar.left
        anchors.top:     parent.top
        anchors.bottom:  parent.bottom

        contentHeight: item.contentHeight + 2 * anchors.margins
        clip:          true
    }

    DebugItem
    {
    }

    function ensureVisible(it, r)
    {
        var rect = it.mapToItem(flickable.contentItem, r.x, r.y, r.width, r.height);

        if (flickable.contentX >= rect.x)
        {
            flickable.contentX = rect.x;
        }
        else if (flickable.contentX + flickable.width <= rect.x + rect.width)
        {
            flickable.contentX = rect.x + rect.width - flickable.width;
        }

        if (flickable.contentY >= rect.y)
        {
            flickable.contentY = rect.y;
        }
        else if (flickable.contentY + flickable.height <= rect.y + rect.height)
        {
            flickable.contentY = rect.y + rect.height - flickable.height;
        }
    }

    function scrollDown()
    {
        flickable.contentY = Math.max(item.contentHeight - flickable.height, 0.0);
    }
}
