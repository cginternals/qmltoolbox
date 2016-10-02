
import QtQuick 2.0

import QmlToolbox.Base 1.0
import QmlToolbox.Ui 1.0


/**
*  ButtonMenu
*
*  A button that opens a list of options
*/
BaseItem
{
    id: item

    default property alias data: items.data

    property alias icon: button.icon
    property alias text: button.text

    implicitWidth:  column.implicitWidth
    implicitHeight: column.implicitHeight

    Column
    {
        id: column

        anchors.top:  parent.top
        anchors.left: parent.left
        spacing:      Ui.style.spacingSmall

        IconButton
        {
            id: button

            onClicked:
            {
                button.selected = !button.selected;
            }
        }

        Column
        {
            id: items

            visible: button.selected
            spacing: Ui.style.spacingSmall
        }
    }
}
