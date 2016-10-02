
import QtQuick 2.0
import QtGraphicalEffects 1.0

import QmlToolbox.Base 1.0


/**
*  Icon
*
*  Displays an icon
*/
BaseItem
{
    id: item

    property string icon:  ''
    property color  color: Ui.style.controlIconColor

    implicitWidth:  Ui.style.iconSizeMedium
    implicitHeight: Ui.style.iconSizeMedium

    ColorOverlay
    {
        anchors.fill: parent

        source: icon
        color:  item.color
    }

    Image
    {
        id: icon

        anchors.fill: parent

        source:  item.icon != '' ? '../../../icons/' + item.icon : ''
        visible: false
    }
}
