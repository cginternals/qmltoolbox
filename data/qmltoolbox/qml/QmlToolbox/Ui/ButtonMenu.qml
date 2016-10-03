
import QtQuick 2.0
import QtQuick.Layouts 1.0

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

    ColumnLayout
    {
        id: column

        width:   parent.width
        spacing: Ui.style.spacingSmall

        IconButton
        {
            id: button

            onClicked:
            {
                button.selected = !button.selected;
            }
        }

        ColumnLayout
        {
            id: items

            width: parent.width

            visible: button.selected
            spacing: Ui.style.spacingSmall
        }
    }
}
