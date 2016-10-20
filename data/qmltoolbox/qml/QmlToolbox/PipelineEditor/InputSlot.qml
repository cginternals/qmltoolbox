
import QtQuick 2.0

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0
import QmlToolbox.PropertyEditor 1.0


/**
*  InputSlot
*
*  Representation of an input slot
*/
BaseItem
{
    id: slot

    // Called when mouse cursor has entered the slot
    signal entered()

    // Called when mouse cursor has left the slot
    signal exited()

    // Called when mouse button has been pressed on the slot
    signal pressed()

    // Options
    property var    pipelineInterface: null       ///< Interface for accessing the pipeline
    property string path:              ''         ///< Path in the pipeline hierarchy (e.g., 'pipeline.stage1.input1')
    property alias  name:              label.text ///< Name of the slot
    property bool   showEditors:       false      ///< Display properties editors?
    property bool   hovered:           false      ///< Is the slot currently hovered?
    property bool   selected:          false      ///< Is the slot currently selected?
    property bool   connectable:       true       ///< Enable interaction for connecting to another slot?
    property int    radius:            Ui.style.pipelineSlotSize
    property color  color:             Ui.style.pipelineSlotColorIn
    property color  borderColor:       Ui.style.pipelineBorderColor
    property int    borderWidth:       Ui.style.pipelineBorderWidth

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
            width:                  slot.radius
            height:                 slot.radius

            radius:       width / 2.0
            color:        slot.selected ? Ui.style.pipelineLineColorSelected : (slot.hovered ? Ui.style.pipelineLineColorHighlighted : slot.color)
            border.color: slot.borderColor
            border.width: slot.borderWidth

            // Mouse area for selection
            MouseArea
            {
                anchors.fill: parent

                hoverEnabled: true

                onEntered: slot.entered();
                onExited:  slot.exited();
                onPressed: slot.pressed();
            }
        }

        // Name of slot
        Label
        {
            id: label

            anchors.verticalCenter: parent.verticalCenter

            text:  'Value'
            color: Ui.style.pipelineStageTextColor
        }

        // Property editor
        ValueEdit
        {
            visible:           slot.showEditors
            pipelineInterface: slot.pipelineInterface
            path:              slot.path

            onPathChanged: update();
        }
    }
}
