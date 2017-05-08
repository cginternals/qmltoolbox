
pragma Singleton


import QtQuick 2.0

import QmlToolbox.Base 1.0


/**
*  Ui
*
*  Global options for the UI, e.g., debug mode
*/
Item
{
    id: item

    // Debug mode
    property bool debugMode: false

    property QtObject style: StyleDefault
    {
    }
}
