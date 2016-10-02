
import QtQuick 2.0

import QmlToolbox.Base 1.0


/**
*  Control
*
*  Base class for controls
*/
BaseItem
{
    id: item

    // Is the item selected?
    property bool selected: false

    // Is the mouse currently over the item?
    property alias hovered: mouseArea.containsMouse

    // Is a mouse button currently pressed over the item?
    property alias pressed: mouseArea.pressed

    // Called when the left mouse button has been clicked on the item
    signal clicked()

    // Called when the right mouse button has been clicked on the item
    signal rightClicked()

    MouseArea
    {
        id: mouseArea

        enabled:      item.enabled
        anchors.fill: parent
        hoverEnabled: true

        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked:
        {
            if (mouse.button == Qt.RightButton)
            {
                item.rightClicked();
            }
            else
            {
                item.clicked();
            }
        }
    }

    /**
    *  Select style based on the current state of the control
    *
    *  @param[in] disabledStyle
    *    Style that is returned when control is disabled
    *  @param[in] pressedStyle
    *    Style that is returned when control is pressed by the mouse
    *  @param[in] hoverStyle
    *    Style that is returned when control is hovered by the mouse
    *  @param[in] selectedStyle
    *    Style that is returned when control is currently selected
    *  @param[in] defaultStyle
    *    Style that is returned when control is in default state
    *
    *  @return
    *    Style that matches the current state
    */
    function selectStyle(disabledStyle, pressedStyle, hoverStyle, selectedStyle, defaultStyle)
    {
             if (!enabled) return disabledStyle;
        else if (pressed)  return pressedStyle;
        else if (hovered)  return hoverStyle;
        else if (selected) return selectedStyle;
        else               return defaultStyle;
    }
}
