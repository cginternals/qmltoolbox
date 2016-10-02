
import QtQuick 2.0

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0


/**
*  PanelMenuItem
*
*  Item on a panel menu.
*  Must be inserted into a PanelMenu!
*/
Control
{
    id: item

    property string icon: '' ///< Button icon
    property string text: '' ///< Button text

    width:          parent.width
    implicitWidth:  row.implicitWidth  + 2 * Ui.style.panelPadding
    implicitHeight: 40

    selected: parent.parent.selected == text

    Rectangle
    {
        id: background

        anchors.fill: parent
        color:        item.selectStyle(Ui.style.panelItemColorDisabled, Ui.style.panelItemColorPressed, Ui.style.panelItemColorHover, Ui.style.panelItemColorSelected, Ui.style.panelItemColor)
    }

    Row
    {
        id: row

        anchors.left:    parent.left
        anchors.top:     parent.top
        anchors.margins: Ui.style.paddingMedium
        spacing:         Ui.style.spacingMedium

        Icon
        {
            anchors.verticalCenter: parent.verticalCenter

            visible: item.icon != ''
            icon:    item.icon
            color:   item.selectStyle(Ui.style.controlIconColorDisabled, Ui.style.controlIconColorPressed, Ui.style.controlIconColorHover, Ui.style.controlIconColorSelected, Ui.style.controlIconColor)
        }

        Label
        {
            anchors.verticalCenter: parent.verticalCenter

            text:  item.text
            color: item.selectStyle(Ui.style.controlTextColorDisabled, Ui.style.controlTextColorPressed, Ui.style.controlTextColorHover, Ui.style.controlTextColorSelected, Ui.style.controlTextColor)
        }
    }

    onClicked:
    {
        parent.parent.selected = text;
    }
}
