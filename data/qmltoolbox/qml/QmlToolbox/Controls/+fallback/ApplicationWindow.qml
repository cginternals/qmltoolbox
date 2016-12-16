
import QtQuick.Controls 1.3


/**
*  Application Window
*
*  Fallback implementation of Application Window using Controls 1.3
*  This implementation renames the toolbar and status bar.
*/
ApplicationWindow 
{
    id: applicationWindow

    property alias header: applicationWindow.toolBar
    property alias footer: applicationWindow.statusBar
}
