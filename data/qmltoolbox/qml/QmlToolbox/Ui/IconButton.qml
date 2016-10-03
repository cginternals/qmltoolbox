
import QtQuick 2.0

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0
import QmlToolbox.Ui 1.0


/**
*  IconButton
*
*  A push button with a label and an optional icon
*/
Control
{
    id: item

    property string icon:              ''                       ///< Button icon
    property string text:              ''                       ///< Button text
    property real   iconWidth:         Ui.style.controlIconSize ///< Icon size
    property real   iconHeight:        Ui.style.controlIconSize ///< Icon size
    property bool   backgroundVisible: true                     ///< Show background?

    implicitWidth:  row.implicitWidth  + 2 * row.anchors.margins
    implicitHeight: row.implicitHeight + 2 * row.anchors.margins

    Rectangle
    {
        id: background

        anchors.fill: parent
        color:        selectStyle(Ui.style.controlColorDisabled, Ui.style.controlColorPressed, Ui.style.controlColorHover, Ui.style.controlColorSelected, Ui.style.controlColor)
        border.color: selectStyle(Ui.style.controlBorderColorDisabled, Ui.style.controlBorderColorPressed, Ui.style.controlBorderColorHover, Ui.style.controlBorderColorSelected, Ui.style.controlBorderColor)
        border.width: Ui.style.controlBorderWidth
        radius:       Ui.style.controlBorderRadius
        visible:      item.backgroundVisible
    }

    Row
    {
        id: row

        anchors.top:     parent.top
        anchors.left:    parent.left
        anchors.margins: Ui.style.controlPadding
        spacing:         Ui.style.controlSpacing

        Icon
        {
            anchors.verticalCenter: parent.verticalCenter

            visible: item.icon != ''
            icon:    item.icon
            color:   selectStyle(Ui.style.controlIconColorDisabled, Ui.style.controlIconColorPressed, Ui.style.controlIconColorHover, Ui.style.controlIconColorSelected, Ui.style.controlIconColor)
            width:   item.iconWidth
            height:  item.iconHeight
        }

        Label
        {
            anchors.verticalCenter: parent.verticalCenter

            text:     item.text
            color:    selectStyle(Ui.style.controlTextColorDisabled, Ui.style.controlTextColorPressed, Ui.style.controlTextColorHover, Ui.style.controlTextColorSelected, Ui.style.controlTextColor)
            fontSize: Ui.style.controlFontSize
        }
    }
}
