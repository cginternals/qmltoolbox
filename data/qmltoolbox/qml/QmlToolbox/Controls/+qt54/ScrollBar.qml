
import QtQuick 2.0
import QtQuick.Controls 1.1

import QmlToolbox.Base 1.0


/**
*  ScrollBar
*
*  Horizontal or vertical scroll bar
*/
Item
{
    id: item

    signal scrolled(real value)

    readonly property bool hovered: mouseArea.containsMouse
    readonly property bool pressed: typeof(mouseArea.containsPress) != 'undefined' ? mouseArea.containsPress : false

    property real position: 0 ///< Current position
    property real size:     0 ///< Current size
    property real maxValue: 0 ///< Maximum size

    property bool vertical: true

    visible: item.maxValue > item.size

    property real fullSize: vertical ? height : width

    Rectangle
    {
        id: handle

        property real size: Math.max(30, Math.min(item.size / item.maxValue, 1.0) * item.fullSize)
        property real handlePos: mouseArea.drag.active ? 0 : (item.position / (item.maxValue - item.size)) * (item.fullSize - handle.size)

        x:      item.vertical ? Ui.style.paddingTiny                    : handlePos
        y:      item.vertical ? handlePos                               : Ui.style.paddingTiny
        width:  item.vertical ? parent.width - 2 * Ui.style.paddingTiny : size
        height: item.vertical ? size                                    : parent.height - 2 * Ui.style.paddingTiny

        color:  item.hovered ? Ui.style.controlColorHovered : Ui.style.controlColor
        radius: Ui.style.scrollBarRadius

        MouseArea
        {
            id: mouseArea

            anchors.fill: parent

            drag.target:   handle
            drag.minimumX: item.vertical ? Ui.style.paddingTiny        : 0
            drag.maximumX: item.vertical ? Ui.style.paddingTiny        : item.width - handle.width
            drag.minimumY: item.vertical ? 0                           : Ui.style.paddingTiny
            drag.maximumY: item.vertical ? item.height - handle.height : Ui.style.paddingTiny

            hoverEnabled: true
        }

        onXChanged:
        {
            if (mouseArea.drag.active && !vertical)
            {
                item.scrolled( Math.max(0, (x / (item.width - handle.width)) * (item.maxValue - item.size)) );
            }
        }

        onYChanged:
        {
            if (mouseArea.drag.active && vertical)
            {
                item.scrolled( Math.max(0, (y / (item.height - handle.height)) * (item.maxValue - item.size)) );
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
            item.scrolled( Math.max(0, item.position - item.size) );
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
            item.scrolled( Math.min(item.maxValue - item.size, item.position + item.size) );
        }
    }
}
