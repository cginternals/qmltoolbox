
import QtQuick 2.0

import QmlToolbox.Base 1.0


/**
*  ScrollPanel
*
*  Panel with a scroll area
*/
Panel
{
    id: panel

    default property alias data:  scrollArea.data

    property alias contentWidth:  scrollArea.contentWidth
    property alias contentHeight: scrollArea.contentHeight
    property alias contentX:      scrollArea.contentX
    property alias contentY:      scrollArea.contentY

    ScrollArea
    {
        id: scrollArea

        anchors.fill: parent
    }
}
