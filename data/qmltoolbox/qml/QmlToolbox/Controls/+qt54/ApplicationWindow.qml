
import QtQuick.Controls 1.0

import QmlToolbox.Base 1.0


/**
*  ApplicationWindow
*
*  Top-level application window
*
*  Implementation of Application Window using Controls 1.0
*/
ApplicationWindow 
{
    id: applicationWindow

    property alias header: applicationWindow.toolBar
    property alias footer: applicationWindow.statusBar

    DebugItem
    {
    }
}
