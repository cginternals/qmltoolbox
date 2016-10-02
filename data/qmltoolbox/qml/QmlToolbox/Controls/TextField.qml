
import QtQuick 2.0
import QtQuick.Controls 1.0 as Controls

import QmlToolbox.Base 1.0


/**
*  LineEdit
*
*  Single-line editable text
*/
Controls.TextField
{
    font.pixelSize: Ui.style.fontSizeMedium

    BaseItem
    {
        anchors.fill: parent
    }
}
