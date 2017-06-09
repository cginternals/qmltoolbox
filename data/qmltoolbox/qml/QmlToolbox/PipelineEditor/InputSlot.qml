
import QtQuick 2.0

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0
import QmlToolbox.PropertyEditor 1.0


/**
*  InputSlot
*
*  Representation of an input slot
*/
Item
{
    id: item

    // Called when mouse cursor has entered the slot
    signal entered()

    // Called when mouse cursor has left the slot
    signal exited()

    // Called when mouse button has been pressed on the slot
    signal pressed()

    // Options
    property var    properties:  null       ///< Interface for accessing the pipeline
    property string path:        ''         ///< Path in the pipeline hierarchy (e.g., 'pipeline.stage1.input1')
    property string slot:        ''         ///< Name of the slot
    property alias  status:      editor.status
    property bool   showEditors: false      ///< Display properties editors?
    property bool   hovered:     false      ///< Is the slot currently hovered?
    property bool   selected:    false      ///< Is the slot currently selected?
    property bool   connectable: true       ///< Enable interaction for connecting to another slot?
    property int    radius:      Ui.style.pipelineSlotSize
    property color  color:       Ui.style.pipelineSlotColorIn
    property color  borderColor: Ui.style.pipelineBorderColor
    property int    borderWidth: Ui.style.pipelineBorderWidth

    implicitWidth:  row.implicitWidth  + 2 * row.anchors.margins
    implicitHeight: row.implicitHeight + 2 * row.anchors.margins

    // Slot container
    Row
    {
        id: row

        anchors.left: parent.left
        anchors.top:  parent.top
        spacing:      Ui.style.paddingSmall

        // Connector
        Rectangle
        {
            id: connector

            anchors.verticalCenter: parent.verticalCenter
            width:                  item.radius
            height:                 item.radius

            radius:       width / 2.0
            color:        item.selected ? Ui.style.pipelineLineColorSelected : (item.hovered ? Ui.style.pipelineLineColorHighlighted : item.color)
            border.color: item.borderColor
            border.width: item.borderWidth

            // Mouse area for selection
            MouseArea
            {
                anchors.fill: parent

                hoverEnabled: true

                onEntered: item.entered();
                onExited:  item.exited();
                onPressed: item.pressed();
            }
        }

        // Name of slot
        Label
        {
            id: label

            anchors.verticalCenter: parent.verticalCenter

            text:  item.slot
            color: Ui.style.pipelineStageTextColor
        }

        // Property editor
        EditorProxy
        {
            id: editor

            visible:    item.showEditors
            properties: item.properties
            path:       item.path
            slot:       item.slot
        }
    }

    Connections
    {
        target: item.properties

        onSlotChanged: // (string path, string slot, var status)
        {
            if (item.path === path && item.slot === slot)
            {
                editor.status = status;
            }
        }
    }
}
