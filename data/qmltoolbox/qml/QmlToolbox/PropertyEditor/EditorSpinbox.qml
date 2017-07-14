
import QtQuick 2.4

import QmlToolbox.Controls 1.0


/**
*  EditorSpinbox
*
*  Editor for properties of type 'int', 'float', etc. with a spin box
*/
Editor
{
    id: item

    implicitWidth:  input.implicitWidth
    implicitHeight: input.implicitHeight

    SpinBox 
    {
        id: input

        anchors.fill: parent

        onValueChanged:
        {
            if (!internal.noUpdate)
            {
                item.properties.setValue(item.path, item.slot, value / input.scaleFactor);
            }
        }
    }

    onStatusChanged:
    {
        internal.noUpdate = true;

        if (status.hasOwnProperty('decimals')) {
            input.decimals = status.decimals;
        }

        if (status.hasOwnProperty('stepSize')) {
            input.realStepSize = status.stepSize;
        }

        if (status.hasOwnProperty('minimumValue')) {
            input.realFrom = status.minimumValue;
        }

        if (status.hasOwnProperty('maximumValue')) {
            input.realTo = status.maximumValue;
        }

        input.value = Math.round(status.value * input.scaleFactor);

        internal.noUpdate = false;
    }

    QtObject
    {
        id: internal

        property bool noUpdate: false
    }
}
