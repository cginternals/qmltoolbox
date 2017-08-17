
import QtQuick.Controls 2.0

import QmlToolbox.Base 1.0


/**
*  Slider
*
*  Horizontal slider for selecting a number
*
*  Default implementation of Slider using Controls 2.0
*/
Slider 
{
    id: slider

    property bool live: false

    onPositionChanged:
    {
        if (live)
        {
            value = from + position * (to - from)
        }
    }

    DebugItem
    {
    }
}
