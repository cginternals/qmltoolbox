
import QtQuick.Controls 1.0


/**
*  Menu
*
*  Menu component for use as a context menu, popup menu, or as part of a menu bar
*
*  Implementation of Menu using Controls 1.0.
*/
Menu 
{
    property real x: 0
    property real y: 0

    function open() 
    {
        this.popup();
    }

    function addMenuItem(title) 
    {
        return this.addItem(title);
    }

    // This must not contain a debug item to prevent malfunction
}
