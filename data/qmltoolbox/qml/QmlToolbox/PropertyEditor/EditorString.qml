
import QtQuick 2.4

import QmlToolbox.Controls 1.0


/**
*  EditorString
*
*  Editor for properties of type 'string'
*/
Editor
{
    id: item

    implicitWidth:  input.implicitWidth
    implicitHeight: input.implicitHeight

    TextField
    {
        id: input

        anchors.fill: parent

        onEditingFinished:
        {
            item.properties.setValue(item.path, item.slot, text);
        }
    }

    onStatusChanged:
    {
        input.text = status.value;
    }
}
