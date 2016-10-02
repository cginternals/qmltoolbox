
import QtQuick 2.0

import QmlToolbox.Base 1.0


/**
*  PanelMenu
*
*  Menu (list) on a panel
*/
BaseItem
{
    id: item

    default property alias data: col.data

    property string selected: ''

    implicitWidth:  col.implicitWidth
    implicitHeight: col.implicitHeight

    Column
    {
        id: col

        width: parent.width
    }
}
