
import QtQuick 2.4

import QtQuick.Controls 1.3
    

/**
*  Shortcut
*
*  Keyboard shortcut
*
*  Default implementation of Shortcut using Controls 1.3
*/
QtObject
{
    id: item

    property alias sequence: action.shortcut

    signal activated()

    property Action _action: Action 
    {
        id: action

        onTriggered: item.activated()
    }
}
