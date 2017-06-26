
import QtQuick 2.4
import QtQuick.Dialogs 1.0

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0


/**
*  EditorFilename
*
*  Editor for properties of type 'filename'
*/
Editor
{
    id: item

    implicitWidth:  input.implicitWidth
    implicitHeight: input.implicitHeight

    TextField
    {
        id: input

        anchors.top:         parent.top
        anchors.bottom:      parent.bottom
        anchors.left:        parent.left
        anchors.right:       button.left
        anchors.rightMargin: Ui.style.paddingMedium

        readOnly: true

        onEditingFinished:
        {
            item.properties.setValue(item.path, item.slot, text);
        }
    }

    Button
    {
        id: button

        anchors.top:    parent.top
        anchors.bottom: parent.bottom
        anchors.right:  parent.right
        implicitWidth:  32

        text: '...'

        onClicked:
        {
            fileDialog.open();
        }
    }

    FileDialog
    {
        id: fileDialog

        title:          'Open texture'
        selectExisting: true
        selectFolder:   false
        selectMultiple: false

        onAccepted:
        {
            var path = QmlUtils.urlToLocalFile(fileUrl);

            input.text = path;
            item.properties.setValue(item.path, item.slot, path);
        }
    }

    onStatusChanged:
    {
        input.text = status.value;

        if (status.hasOwnProperty('folder')) {
            fileDialog.folder = status.folder;
        }
    }
}
