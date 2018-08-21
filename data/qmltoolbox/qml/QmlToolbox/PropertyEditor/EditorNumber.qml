
import QtQuick 2.4

import QmlToolbox.Controls 1.0


/**
*  EditorNumber
*
*  Editor for properties of type 'int', 'float', etc.
*/
Editor
{
    id: item

    implicitWidth:  input.implicitWidth
    implicitHeight: input.implicitHeight * 0.9 + label.implicitHeight

    Slider
    {
        id: input

        anchors.fill: parent

        onValueChanged:
        {
            if (!internal.noUpdate)
            {
                item.properties.setValue(item.path, item.slot, value);
            }
        }
    }

    Label
    {
        id: label

        x: (input.value - input.minimumValue) / (input.maximumValue - input.minimumValue) * input.width - (width / 2.0)
        y: input.height * 0.9

        text: input.value.toPrecision(2);
    }

    onStatusChanged:
    {
        internal.noUpdate = true;

        if (status.hasOwnProperty('minimumValue')) {
            input.from = status.minimumValue;
        }

        if (status.hasOwnProperty('maximumValue')) {
            input.to = status.maximumValue;
        }

        if (status.hasOwnProperty('updateOnDrag')) {
            input.live = status.updateOnDrag;
        }

        input.value = status.value;

        internal.noUpdate = false;
    }

    QtObject
    {
        id: internal

        property bool noUpdate: false
    }
}
