
import QtQuick 2.4
import QtQuick.Layouts 1.1

import QmlToolbox.Controls 1.0


/**
*  PropertyEditor
*
*  Displays a list of editors for property values
*/
Pane
{
    id: item

    property var    properties:     null ///< Interface for communicating with the actual pipeline
    property string path:           ''   ///< Path to pipeline or stage (e.g., 'pipeline')
    property string categoryFilter: ''   ///< If set, only properties in the given category are displayed
    property bool   compact:        true ///< If 'true', caption and control are put on one line, otherwise on two
    property int    spacing:        12   ///< Spacing between lines

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

        columns:       item.compact ? 2 : 1
        rowSpacing:    item.spacing
        columnSpacing: 16
    }

    function clear()
    {
        // Clear editors
        var editors = [];

        for (var i=0; i<layout.children.length; i++)
        {
            editors.push(layout.children[i]);

        }

        for (var i=0; i<editors.length; i++)
        {
            editors[i].destroy();
        }
    }

    function update()
    {
        // Destroy old editors
        clear();

        // Get stage info
        var stage = item.properties.getStage(path);

        // Process input slots
        var num = stage.inputs.length || 0;
        for (var i = 0; i < num; i++)
        {
            // Get input slot
            var slot   = stage.inputs[i];
            var status = item.properties.getSlot(path, slot);

            // Create editor item
            createEditor(path, slot, status);
        }
    }

    function createEditor(path, slot, status)
    {
        // Abort if slot is hidden
        if (status.hasOwnProperty('hidden'))
        {
            if (status.hidden == true)
                return;
        }

        if (item.categoryFilter !== '')
        {
            var category = status.hasOwnProperty('category') ? status.category : '';

            if (category !== item.categoryFilter)
                return;
        }

        // Create caption
        var caption = editorCaption.createObject(layout, {
            text: slot
        } );

        // Create editor
        var editor = editorProxy.createObject(layout, {
            properties: item.properties,
            path: path,
            slot: slot,
            status: status
        } );
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
                    it.status = status;
                }
            }
        }
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
        id: editorProxy

        EditorProxy
        {
            Layout.fillWidth: true
        }
    }
}
