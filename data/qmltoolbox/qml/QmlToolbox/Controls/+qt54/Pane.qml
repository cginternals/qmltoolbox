
import QtQuick 2.4

import QmlToolbox.Base 1.0


/**
*  Pane
*
*  Provides a background matching with the application style and theme
*
*  Implementation of Pane using QtQuick 2.4
*/
Control 
{
    id: item

    padding: Ui.style.paddingLarge

    property real contentWidth:  contentItem.childWidth
    property real contentHeight: contentItem.childHeight

    implicitWidth:  contentWidth  + leftPadding + rightPadding
    implicitHeight: contentHeight + topPadding  + bottomPadding
}
