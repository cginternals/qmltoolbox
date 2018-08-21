
import QtQuick.Controls 1.1

import QmlToolbox.Base 1.0


/**
*  Slider
*
*  Horizontal slider for selecting a number
*
*  Default implementation of Slider using Controls 1.1
*/
Slider
{
    id: slider

    property alias live: slider.updateValueWhileDragging

    property alias from: slider.minimumValue
    property alias to:   slider.maximumValue

    DebugItem
    {
    }
}
