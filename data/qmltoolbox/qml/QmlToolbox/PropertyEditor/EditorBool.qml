
import QtQuick 2.4

import QmlToolbox.Controls 1.0


/**
*  EditorBool
*
*  Editor for properties of type 'bool'
*/
Editor
{
    id: item

    implicitWidth:  input.implicitWidth
    implicitHeight: input.implicitHeight

    Switch
    {
        id: input

        anchors.fill: parent

        onClicked:
        {
            item.properties.setValue(item.path, item.slot, checked);
        }
    }

    onStatusChanged:
    {
        input.checked = (status.value == 'true' || status.value == true);
    }
}
