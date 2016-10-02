
import QtQuick 2.0
import QtQuick.Controls 1.1 as Controls
import QtQuick.Controls.Styles 1.1

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0


/**
*  CheckBox
*
*  Styled check box
*/
Controls.CheckBox
{
    id: cb

    style: CheckBoxStyle
    {
        label: Label
        {
            text: cb.text
        }
    }

    BaseItem
    {
        anchors.fill: parent
    }
}
