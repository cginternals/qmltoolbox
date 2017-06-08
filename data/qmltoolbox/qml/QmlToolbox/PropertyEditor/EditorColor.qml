
import QtQuick 2.4
import QtQuick.Dialogs 1.0


/**
*  EditorColor
*
*  Editor for properties of type 'color'
*/
Editor
{
    id: item

    implicitWidth:  input.implicitWidth
    implicitHeight: input.implicitHeight

    Rectangle
    {
        id: input

        anchors.fill: parent

        implicitWidth:  150
        implicitHeight: 25

        color: '#000000'

        MouseArea
        {
            anchors.fill: parent

            onClicked:
            {
                colorDialog.color = input.color;
                colorDialog.open();
            }
        }
    }

    ColorDialog
    {
        id: colorDialog

        onAccepted:
        {
            input.color = color;

            item.properties.setValue(item.path, item.slot, color.toString());
        }
    }

    onStatusChanged:
    {
        input.color = status.value;
    }
}
