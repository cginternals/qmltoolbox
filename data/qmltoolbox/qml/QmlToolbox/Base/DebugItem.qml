
import QtQuick 2.4
import QtQuick.Controls 1.0

import QmlToolbox.Base 1.0


/**
*  DebugItem
*
*  Visual debug item.
*
*  This class adds debug capabilities to items. If Ui.debugMode is enabled,
*  it will draw a colored rectangle around the space of the item to visualize
*  the item extends.
* 
*  To avoid overdraw this item should be arranged last within a control.
*/
Rectangle
{
    anchors.fill: parent

    // enable this item only if debugMode is enabled
    enabled: Ui.debugMode
    visible: Ui.debugMode

    color: 'transparent'
    border.color: Ui.style.debugColor
    border.width: 1

    opacity: mouseArea.containsMouse ? 1.0 : 0.33

    MouseArea
    {
        id: mouseArea

        anchors.fill: parent

        hoverEnabled: true

        propagateComposedEvents: true

        onClicked:         mouse.accepted = false;
        onPressed:         mouse.accepted = false;
        onReleased:        mouse.accepted = false;
        onDoubleClicked:   mouse.accepted = false;
        onPositionChanged: mouse.accepted = false;
        onPressAndHold:    mouse.accepted = false;
    }

    Text 
    {
        anchors.fill: parent

        wrapMode: Text.WordWrap

        opacity: 0.66
        color: Ui.style.debugColor

        visible: mouseArea.containsMouse

        text: "x" + parent.parent.x + ", y" + parent.parent.y +
              ", w" + parent.parent.width + ", h" + parent.parent.height
    }
}
