
import QtQuick 2.4
import QtQuick.Controls 2.0

import QmlToolbox.Base 1.0


/**
*  SpinBox
*
*  SpinBox input for selecting a number
*
*  Default implementation of ComboBox using Controls 2.0
*/
SpinBox 
{
    id: spinbox

    property int decimals:      0    ///< Number of decimals in the spin box

    property real realFrom:     0.0  ///< Minimum number
    property real realTo:       99.0 ///< Maximum number
    property real realStepSize: 1.0  ///< To set a custom step size

    property real scaleFactor:  Math.pow(10, spinbox.decimals)

    from:     realFrom * scaleFactor
    to:       realTo * scaleFactor
    stepSize: realStepSize * scaleFactor

    editable: true

    DebugItem
    {
    }

    validator: DoubleValidator
    {
        bottom: Math.min(spinbox.from, spinbox.to)
        top:    Math.max(spinbox.from, spinbox.to)
    }

    textFromValue: function(value, locale)
    {
        return Number(value / scaleFactor).toLocaleString(locale, 'f', spinbox.decimals);
    }

    valueFromText: function(text, locale)
    {
        return Number.fromLocaleString(locale, text) * scaleFactor;
    }
}
