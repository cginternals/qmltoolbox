
import QtQuick 2.0
import QtQuick.Controls 1.1 as Controls
import QtQuick.Controls.Styles 1.1

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0


/**
*  RadioButton
*
*  Styled radio button
*/
Controls.RadioButton
{
    id: rb

    style: RadioButtonStyle
    {
        label: Label
        {
            text: rb.text
        }
    }

    BaseItem
    {
        anchors.fill: parent
    }
}
