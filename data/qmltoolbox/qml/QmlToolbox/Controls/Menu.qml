
import QtQuick 2.0
import QtQuick.Controls 2.0

import QmlToolbox.Base 1.0


/**
*  Menu
*
*  Menu component for use as a context menu, popup menu, or as part of a menu bar
*
*  Default implementation of Menu using Controls 2.0
*/
Menu 
{
    // This must not contain a debug item to prevent malfunction
    id: menu

    function addMenuItem(title) {
        var newItem = menuItem.createObject(menu, { text: title });
        menu.addItem(newItem);
        return newItem;
    }

    Component
    {
        id: menuItem

        MenuItem
        {
        }
    }
}
