
import QtQuick 2.0

import QmlToolbox.Base 1.0


/**
*  ButtonBar
*
*  Horizontal list of buttons
*/
BaseItem
{
    id: item

    default property alias data: row.data

    property alias spacing: row.spacing

    implicitWidth:  row.implicitWidth
    implicitHeight: row.implicitHeight

    Row
    {
        id: row

        anchors.top:  parent.top
        anchors.left: parent.left
        spacing:      Ui.style.spacingMedium
    }
}
