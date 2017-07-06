
import QtQuick.Controls 1.0

import QmlToolbox.Base 1.0


/**
*  SpinBox
*
*  SpinBox input for selecting a number
*
*  Implementation of ComboBox using Controls 1.0
*/
SpinBox
{
    id: spinbox

    property alias realFrom:     spinbox.minimumValue
    property alias realTo:       spinbox.maximumValue
    property alias realStepSize: spinbox.stepSize

    property int scaleFactor:    1 ///< For compatibility to implementation based on QtQuick Controls 2.0

    DebugItem
    {
    }
}
