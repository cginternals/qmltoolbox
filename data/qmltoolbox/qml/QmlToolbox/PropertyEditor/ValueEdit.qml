
import QtQuick 2.4
import QtQuick.Layouts 1.1

import QmlToolbox.Controls 1.0 as Controls


Item 
{
    id: item

    property var    pipelineInterface: null ///< Interface for communicating with the actual pipeline
    property string path:              ''   ///< Path to pipeline slot (e.g., 'pipeline.Stage1.in1')

    property Item   input:     null
    property string inputType: ''

    implicitWidth:  layout.implicitWidth
    implicitHeight: layout.implicitHeight

    function update()
    {
        // Get slot type
        var slotInfo = pipelineInterface.getSlot(path);

        if (!slotInfo.type || slotInfo.type == '')
            return;

        // Need to (re-)create editor?
        if (input == null || inputType != slotInfo.type)
        {
            // Destroy old editor
            if (input != null)
            {
                input.destroy();
            }

            // Create editor
            inputType = slotInfo.type;
            if (slotInfo.type == 'bool')
                input = editBool.createObject(inputWrapper);
            else if (slotInfo.type == 'int' || slotInfo.type == 'float')
                input = editNumber.createObject(inputWrapper);
            else if (slotInfo.type == 'color')
                input = editColor.createObject(inputWrapper);
            else if (slotInfo.type == 'filename')
                input = editFilename.createObject(inputWrapper);
            else
                input = editString.createObject(inputWrapper);
        }

        // Update editor
        input.update();
    }

    ColumnLayout 
    {
        id: layout

        anchors.fill: parent

        Controls.Label 
        {
            text: pipelineInterface.getSlot(path).name
        }

        Item 
        {
            id: inputWrapper

            implicitWidth:  input ? input.implicitWidth  : 0
            implicitHeight: input ? input.implicitHeight : 0
        }
    }

    Component
    {
        id: editString

        ValueEditString
        {
            anchors.fill: parent

            pipelineInterface: item.pipelineInterface
            path:              item.path
        }
    }

    Component
    {
        id: editFilename

        ValueEditFilename
        {
            anchors.fill: parent

            pipelineInterface: item.pipelineInterface
            path:              item.path
        }
    }

    Component
    {
        id: editBool

        ValueEditBool
        {
            anchors.fill: parent

            pipelineInterface: item.pipelineInterface
            path:              item.path
        }
    }

    Component
    {
        id: editNumber

        ValueEditNumber
        {
            anchors.fill: parent

            pipelineInterface: item.pipelineInterface
            path:              item.path
        }
    }

    Component
    {
        id: editColor

        ValueEditColor
        {
            anchors.fill: parent

            pipelineInterface: item.pipelineInterface
            path:              item.path
        }
    }
}
