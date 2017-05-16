
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

    ScrollBar
    {
        id: verticalScrollBar

        anchors.right:   parent.right
        anchors.top:     parent.top
        anchors.bottom:  horizontalScrollBar.top
        anchors.margins: Ui.style.paddingTiny
        width:           Ui.style.scrollBarSize

        vertical: true
        position: flickable.contentY
        size:     flickable.height
        maxValue: flickable.contentHeight

        onScrolled:
        {
            flickable.contentY = value;
        }
    }

    ScrollBar
    {
        id: horizontalScrollBar

        anchors.bottom:  parent.bottom
        anchors.left:    parent.left
        anchors.right:   verticalScrollBar.left
        anchors.margins: Ui.style.paddingTiny
        height:          Ui.style.scrollBarSize

        vertical: false
        position: flickable.contentX
        size:     flickable.width
        maxValue: flickable.contentWidth

        onScrolled:
        {
            flickable.contentX = value;
        }
    }

    Flickable
    {
        id: flickable

        anchors.left:    parent.left
        anchors.right:   verticalScrollBar.visible ? verticalScrollBar.left : parent.right
        anchors.top:     parent.top
        anchors.bottom:  horizontalScrollBar.visible ? horizontalScrollBar.top : parent.bottom

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
