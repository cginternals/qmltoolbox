
import QtQuick 2.0

import QmlToolbox.Base 1.0


/**
*  Label
*
*  Displays a text with default style
*/
Text
{
    id: item

    color:          Ui.style.textColor
    linkColor:      Ui.style.linkColor
    font.pixelSize: Ui.style.fontSizeMedium
    wrapMode:       Text.Wrap

    BaseItem
    {
        anchors.fill: parent
    }
}
