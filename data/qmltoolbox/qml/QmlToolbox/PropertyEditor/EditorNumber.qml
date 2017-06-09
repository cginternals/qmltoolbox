
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
    implicitHeight: input.implicitHeight

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

    onStatusChanged:
    {
        internal.noUpdate = true;

        if (status.hasOwnProperty('minimumValue')) {
            input.from = status.minimumValue;
        }

        if (status.hasOwnProperty('maximumValue')) {
            input.to = status.maximumValue;
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
