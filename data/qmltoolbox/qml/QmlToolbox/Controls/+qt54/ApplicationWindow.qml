
import QtQuick.Controls 1.0

import QmlToolBox.Base 1.0


/**
*  Application Window
*
*  Implementation of Application Window using Controls 1.0
*  This implementation renames the toolbar and status bar.
*/
ApplicationWindow 
{
    id: applicationWindow

    property alias header: applicationWindow.toolBar
    property alias footer: applicationWindow.statusBar

    DebugItem { }
}
