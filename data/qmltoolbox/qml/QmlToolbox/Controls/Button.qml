
import QtQuick 2.0
import QtQuick.Controls 1.0 as Controls
import QtQuick.Controls.Styles 1.3

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0


/**
*  Button
*
*  Dialog button
*/
Controls.Button
{
    id: button

    style: ButtonStyle
    {
        label: Label
        {
            text:  button.text
            color: Ui.style.buttonTextColor
        }
    }

    BaseItem
    {
        anchors.fill: parent
    }
}
