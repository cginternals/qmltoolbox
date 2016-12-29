
import QtQuick.Controls 1.0


/**
*  Menu
*
*  Implementation of Menu using Controls 1.0.
*/
Menu 
{
    property real y: 0

    function open() 
    {
        this.popup();
    }

    // This should not contain a debug item to prevent malfunction
}