
import QtQuick.Controls 2.0

import QmlToolbox.Base 1.0


/**
*  MenuItem
*
*  Item in a menu
*
*  Default implementation of MenuItem using Controls 2.0
*/
MenuItem 
{
    highlighted: down || visualFocus || hovered

    DebugItem
    {
    }
}
