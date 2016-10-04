
import QtQuick 2.0

import QmlToolbox.Base 1.0


/**
*  Frame
*
*  Container on a page
*/
BaseItem
{
    id: item

    default property alias data: content.data

    property color backgroundColor: Ui.style.frameColor
    property color borderColor:     Ui.style.frameBorderColor
    property int   borderWidth:     Ui.style.frameBorderWidth
    property int   radius:          Ui.style.frameBorderRadius

    Rectangle
    {
        id: rect

        anchors.fill: parent

        color:        item.backgroundColor
        border.color: item.borderColor
        border.width: item.borderWidth
        radius:       item.radius

        Item
        {
            id: content

            anchors.fill:    parent
            anchors.margins: rect.border.width
        }
    }
}
