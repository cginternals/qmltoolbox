
import QtQuick 2.0

import QmlToolbox.Base 1.0


/**
*  Frame
*
*  Container on a page
*/
BaseItem
{
    default property alias data: content.data

    Rectangle
    {
        id: rect

        anchors.fill: parent

        color:        Ui.style.frameColor
        border.color: Ui.style.frameBorderColor
        border.width: Ui.style.frameBorderWidth
        radius:       Ui.style.frameBorderRadius

        Item
        {
            id: content

            anchors.fill:    parent
            anchors.margins: rect.border.width
        }
    }
}
