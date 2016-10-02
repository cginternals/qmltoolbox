
import QtQuick 2.0

import QmlToolbox.Base 1.0


/**
*  Panel
*
*  Panel on a window or dialog
*/
BaseItem
{
    id: item

    property color backgroundColor: Ui.style.panelColor

    Rectangle
    {
        anchors.fill: parent

        color: item.backgroundColor
    }
}
