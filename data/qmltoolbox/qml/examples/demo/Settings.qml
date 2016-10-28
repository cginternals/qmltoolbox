
import QtQuick 2.0

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0


/**
*  SettingsWindow
*
*  Settings dialog
*/
Window
{
    title:   "Settings"
    visible: false
    width:   800
    height:  600

    // Left panel
    ScrollPanel
    {
        id: leftPane

        anchors.left:   parent.left
        anchors.top:    parent.top
        anchors.bottom: parent.bottom
        width:          250

        contentHeight: menu.height

        PanelMenu
        {
            id: menu

            width: parent.width

            selected: 'General'

            PanelMenuItem
            {
                text:    'General'
                icon:    '0147-equalizer.png'
            }

            PanelMenuItem
            {
                text:    'Input'
                icon:    '0086-keyboard.png'
            }

            PanelMenuItem
            {
                text:    'Plugins'
                icon:    '0169-hammer2.png'
            }
        }
    }

    // Page 'General'
    SettingsGeneral
    {
        id: pageGeneral

        anchors.left:   leftPane.right
        anchors.right:  parent.right
        anchors.top:    parent.top
        anchors.bottom: parent.bottom

        visible: menu.selected == 'General'
    }

    // Page 'Input'
    Item
    {
        id: pageInput

        anchors.left:   leftPane.right
        anchors.right:  parent.right
        anchors.top:    parent.top
        anchors.bottom: parent.bottom

        visible: menu.selected == 'Input'
    }

    // Page 'Plugins'
    Item
    {
        id: pagePlugins

        anchors.left:   leftPane.right
        anchors.right:  parent.right
        anchors.top:    parent.top
        anchors.bottom: parent.bottom

        visible: menu.selected == 'Plugins'
    }
}
