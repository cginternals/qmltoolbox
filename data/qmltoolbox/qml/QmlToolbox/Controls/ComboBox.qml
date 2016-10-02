
import QtQuick 2.0
import QtQuick.Controls 1.0 as Controls
import QtQuick.Controls.Styles 1.3

import QmlToolbox.Base 1.0


/**
*  ComboBox
*
*  Editable Drop-Down ComboBox
*/
Controls.ComboBox
{
    style: ComboBoxStyle
    {
        font.pixelSize: Ui.style.fontSizeMedium
    }

    BaseItem
    {
        anchors.fill: parent
    }
}
