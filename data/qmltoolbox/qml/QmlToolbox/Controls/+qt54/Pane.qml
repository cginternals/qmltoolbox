
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

    padding: Ui.style.panePadding

    property real contentWidth:  contentItem.implicitWidth
    property real contentHeight: contentItem.implicitHeight

    implicitWidth:  contentWidth  + leftPadding + rightPadding
    implicitHeight: contentHeight + topPadding  + bottomPadding
}
