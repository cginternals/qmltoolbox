
import QtQuick 2.4

import QtQuick.Controls 1.3
    

/**
*  Shortcut
*
*  Default implementation of Shortcut using Controls 1.3
*/
QtObject
{
    id: root

    property alias sequence: action.shortcut

    signal activated()

    property Action _action: Action 
    {
        id: action

        onTriggered: root.activated()
    }
}
