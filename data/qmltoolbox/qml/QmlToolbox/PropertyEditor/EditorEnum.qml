
import QtQuick 2.4

import QmlToolbox.Controls 1.0


/**
*  EditorEnum
*
*  Editor for properties of type 'enum'
*/
Editor
{
    id: item

    implicitWidth:  input.implicitWidth
    implicitHeight: input.implicitHeight

    ComboBox
    {
        id: input

        anchors.fill: parent

        onActivated:
        {
            item.properties.setValue(item.path, item.slot, input.model[index]);
        }
    }

    onStatusChanged:
    {
        input.model = status.choices;
        input.currentIndex = status.choices.indexOf(status.value);
    }
}
