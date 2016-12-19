
import QtQuick 2.7
import QtQuick.Controls 2.0

import QmlToolbox.Base 1.0


/**
*  DebugItem
*
*  Visual debug item.
*
*  This class adds debug capabilities to items. If Ui.debugMode is enabled,
*  it will draw a colored rectangle around the space of the item to visualize
*  the item extends.
*/
Rectangle
{
    anchors.fill: parent

    // enable this item only if debugMode is enabled
    enabled: Ui.debugMode
    visible: Ui.debugMode

    color: 'transparent'
    border.color: Ui.debugColor
    border.width: 1
}
