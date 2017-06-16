
import QtQuick 2.0
import QtQuick.Controls 2.0

import QmlToolbox.Base 1.0


/**
*  RangeSlider
*
*  Horizontal slider for selecting a minimum and a maximum number
*
*  Default implementation of RangeSlider using Controls 2.0
*/
Item
{
    id: item

    signal valuesChanged(real firstValue, real secondValue);

    property real firstValue:  0.0
    property real secondValue: 1.0
    property real from:        0.0
    property real to:          1.0
    property bool live:        false

    implicitWidth:  slider.implicitWidth
    implicitHeight: slider.implicitHeight

    onFirstValueChanged:
    {
        if (!internal.noInternalUpdate)
        {
            internal.noExternalUpdate = true;
            slider.first.value = firstValue;
            internal.noExternalUpdate = false;
        }
    }

    onSecondValueChanged:
    {
        if (!internal.noInternalUpdate)
        {
            internal.noExternalUpdate = true;
            slider.second.value = secondValue;
            internal.noExternalUpdate = false;
        }
    }

    RangeSlider
    {
        id: slider

        readonly property real readFirstValue:  slider.first.value
        readonly property real readSecondValue: slider.second.value

        anchors.fill: parent

        from: item.from
        to:   item.to

        onReadFirstValueChanged:
        {
            if (!internal.noExternalUpdate)
            {
                internal.noInternalUpdate = true;
                item.firstValue = first.value;
                internal.noInternalUpdate = false;

                item.valueChanged(first.value, second.value);
            }
        }

        onReadSecondValueChanged:
        {
            if (!internal.noExternalUpdate)
            {
                internal.noInternalUpdate = true;
                item.secondValue = second.value;
                internal.noInternalUpdate = false;

                item.valueChanged(first.value, second.value);
            }
        }
    }

    QtObject
    {
        id: internal

        property bool noInternalUpdate: false
        property bool noExternalUpdate: false
    }

    DebugItem
    {
    }
}
