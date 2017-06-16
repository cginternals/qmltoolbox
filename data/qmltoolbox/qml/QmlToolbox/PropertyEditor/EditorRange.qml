
import QtQuick 2.4

import QmlToolbox.Controls 1.0


/**
*  EditorRange
*
*  Editor for properties of type 'range'
*/
Editor
{
    id: item

    implicitWidth:  input.implicitWidth
    implicitHeight: input.implicitHeight

    RangeSlider
    {
        id: input

        anchors.fill: parent

        onValuesChanged:
        {
            var values = [ firstValue, secondValue ];
            item.properties.setValue(item.path, item.slot, values);
        }
    }

    onStatusChanged:
    {
        if (status.hasOwnProperty('minimumValue')) {
            input.from = status.minimumValue;
        }

        if (status.hasOwnProperty('maximumValue')) {
            input.to = status.maximumValue;
        }

        if (status.hasOwnProperty('updateOnDrag')) {
            input.live = status.updateOnDrag;
        }

        var values = status.value;
        input.firstValue  = values[0];
        input.secondValue = values[1];
    }
}
