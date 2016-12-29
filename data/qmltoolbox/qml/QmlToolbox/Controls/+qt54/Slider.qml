
import QtQuick.Controls 1.1

import QmlToolBox.Base 1.0
    

/**
*  Slider
*
*  Default implementation of Slider using Controls 1.1
*/
Slider
{
    id: slider

    property alias from: slider.minimumValue
    property alias to: slider.maximumValue

    updateValueWhileDragging: false

    DebugItem { }
}
