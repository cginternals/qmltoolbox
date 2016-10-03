
import QtQuick 2.0

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0


/**
*  GroupBox
*
*  Panel with a border and title
*/
BaseItem
{
    id: item

    default property alias data: content.data

    property string title: ''

    height: rect.height + label.height

    Rectangle
    {
        id: labelContainer

        anchors.top:        parent.top
        anchors.left:       parent.left
        anchors.leftMargin: Ui.style.paddingLarge
        implicitWidth:      label.implicitWidth  + 2 * label.anchors.margins
        implicitHeight:     label.implicitHeight + 2 * label.anchors.margins

        z: 2

        color: rect.color

        Label
        {
            id: label

            anchors.fill:    parent
            anchors.margins: Ui.style.paddingSmall

            text:   item.title
            weight: Font.Bold
        }
    }

    Rectangle
    {
        id: rect

        anchors.top: labelContainer.verticalCenter
        width:       parent.width
        height:      content.height + 2 * content.anchors.topMargin

        color:        Ui.style.panelColorAlt
        border.color: Ui.style.borderColor
        border.width: Ui.style.borderWidth
        radius:       Ui.style.borderRadius

        Item
        {
            id: content

            anchors.left:        parent.left
            anchors.right:       parent.right
            anchors.top:         parent.top
            anchors.leftMargin:  Ui.style.paddingMedium
            anchors.rightMargin: Ui.style.paddingMedium
            anchors.topMargin:   Ui.style.paddingMedium + Math.floor(labelContainer.implicitHeight / 2)

            height: childrenRect.height
        }
    }
}
