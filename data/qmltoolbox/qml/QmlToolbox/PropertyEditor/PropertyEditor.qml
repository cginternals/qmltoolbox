
import QtQuick 2.4
import QtQuick.Layouts 1.1

import QmlToolbox.Controls 1.0


Pane
{
    id: item

    property var    properties: null ///< Interface for communicating with the actual pipeline
    property string path:       ''   ///< Path to pipeline or stage (e.g., 'pipeline')

    Connections
    {
        target: item.properties

        onSlotChanged: // (string path, string slot, var status)
        {
            item.updateEditor(slot, status);
        }
    }

    GridLayout
    {
        id: layout

        width: parent.width

        columns:        2
        rowSpacing:    12
        columnSpacing: 16
    }

    function update()
    {
        // Get stage info
        var stage = item.properties.getStage(path);

        // Process input slots
        var num = stage.inputs.length || 0;
        for (var i = 0; i < num; i++)
        {
            // Get input slot
            var name = stage.inputs[i];
            var slot = item.properties.getSlot(path, name);

            // Create editor item
            createEditor(path, name, slot);
        }
    }

    function updateEditor(slot, status)
    {
        // Find editor
        for (var i = 0; i < layout.children.length; i++)
        {
            var it = layout.children[i];

            if (it.hasOwnProperty('slot'))
            {
                if (it.slot === slot)
                {
                    // console.log('SET ' + item.path + '.' + slot + ': ' + JSON.stringify(status));
                    it.status = status;
                }
            }
        }
    }

    function createEditor(path, slot, status)
    {
        // Create caption
        var caption = editorCaption.createObject(layout, {
            text: slot
        } );

        // Choose editor
        var editorType = editorNone;
             if (status.type === 'string' && status.hasOwnProperty('choices')) editorType = editorEnum;
        else if (status.type === 'string')                                     editorType = editorString;
        else if (status.type === 'filename')                                   editorType = editorFilename;
        else if (status.type === 'bool')                                       editorType = editorBool;
        else if (status.type === 'int' || status.type === 'float')             editorType = editorNumber;
        else if (status.type === 'color')                                      editorType = editorColor;
        else if (status.type === 'enum')                                       editorType = editorEnum;
        if (!editorType) return;

        // Create editor
        var editor = editorType.createObject(layout, {
            properties: item.properties,
            path: path,
            slot: slot,
            status: status
        } );
    }

    Component
    {
        id: editorCaption

        Label
        {
        }
    }

    Component
    {
        id: editorString

        EditorString
        {
            Layout.fillWidth: true
        }
    }

    Component
    {
        id: editorFilename

        EditorFilename
        {
            Layout.fillWidth: true
        }
    }

    Component
    {
        id: editorBool

        EditorBool
        {
            Layout.fillWidth: true
        }
    }

    Component
    {
        id: editorNumber

        EditorNumber
        {
            Layout.fillWidth: true
        }
    }

    Component
    {
        id: editorColor

        EditorColor
        {
            Layout.fillWidth: true
        }
    }

    Component
    {
        id: editorEnum

        EditorEnum
        {
            Layout.fillWidth: true
        }
    }

    Component
    {
        id: editorNone

        Editor
        {
            Layout.fillWidth: true
        }
    }
}
