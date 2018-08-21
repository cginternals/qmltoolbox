
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
    implicitHeight: input.implicitHeight * 0.9 + label1.implicitHeight

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

    Label
    {
        id: label1

        x: (input.firstValue - input.from) / (input.to - input.from) * input.width - (width / 2.0)
        y: input.height * 0.9

        text: input.firstValue.toPrecision(2);
    }

    Label
    {
        id: label2

        x: (input.secondValue - input.from) / (input.to - input.from) * input.width - (width / 2.0)
        y: input.height * 0.9

        text: input.secondValue.toPrecision(2);
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
