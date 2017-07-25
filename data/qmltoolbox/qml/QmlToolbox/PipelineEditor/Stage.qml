
import QtQuick 2.0

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0


/**
*  Stage
*
*  Representation of a stage in a pipeline
*/
Item
{
    id: stage

    // Called when the close-button of the stage has been clicked
    signal closed()

    // Options
    property var    properties:     null    ///< Interface for accessing the pipeline
    property Item   pipeline:       null    ///< Pointer to pipeline item
    property string path:           ''      ///< Path in the pipeline hierarchy (e.g., 'pipeline.stage1')
    property string name:           'Stage' ///< Name of the stage
    property bool   includeInputs:  true    ///< Display input slots on the stage?
    property bool   includeOutputs: true    ///< Display output slots on the stage?
    property bool   inverse:        false   ///< Reverse input and output slot positions?
    property bool   allowClose:     true    ///< Enable close-button on the stage?
    property int    radius:         Ui.style.pipelineSlotSize
    property color  color:          Ui.style.pipelineTitleColor

    // Internals
    property var slotItems: null ///< Item cache

    implicitWidth:  Math.max(connectors.implicitWidth, body.implicitWidth + radius)
    implicitHeight: connectors.implicitHeight + title.implicitHeight + Ui.style.paddingLarge
    Drag.active:    mouseArea.drag.active

    // Dialog for creating slots on a stage
    AddSlotDialog
    {
        id: dialog

        onCreateSlot:
        {
            properties.createSlot(stage.path, name, slotType, type);
            stage.update();
        }
    }

    // Context menu
    Menu
    {
        id: menu

        title: "Stage"

        MenuItem
        {
            text: 'Add Input'

            onTriggered:
            {
                dialog.slotType = 'Input';
                dialog.setChoices(properties.getSlotTypes(stage.path));
                dialog.open();
            }
        }

        MenuItem
        {
            text: 'Add Output'

            onTriggered:
            {
                dialog.slotType = 'Output';
                dialog.setChoices(properties.getSlotTypes(stage.path));
                dialog.open();
            }
        }
    }

    // Stage body
    Rectangle
    {
        id: body

        anchors.fill:        parent
        anchors.leftMargin:  stage.radius / 2
        anchors.rightMargin: stage.radius / 2
        implicitWidth:       title.implicitWidth + 2 * title.anchors.margins

        color:        Ui.style.pipelineStageColor
        border.color: Ui.style.pipelineBorderColor
        border.width: Ui.style.pipelineBorderWidth
        radius:       Ui.style.pipelineStageRadius

        // Title bar
        Rectangle
        {
            id: title

            anchors.top:     parent.top
            anchors.left:    parent.left
            anchors.right:   parent.right
            anchors.margins: body.border.width
            implicitWidth:   label.implicitWidth + 3 * label.anchors.margins + icon.implicitWidth
            implicitHeight:  label.implicitHeight + 2 * label.anchors.margins

            radius: body.radius
            color:  stage.color
            clip:   true

            // Fill round edges
            Rectangle
            {
                anchors.left:   parent.left
                anchors.right:  parent.right
                anchors.bottom: parent.bottom
                height:         parent.height / 2
                color:          parent.color
            }

            // Title
            Label
            {
                id: label

                anchors.fill:    parent
                anchors.margins: Ui.style.paddingMedium

                text:  stage.name
                color: Ui.style.pipelineTitleTextColor
            }

            // Mouse area for dragging
            MouseArea
            {
                id: mouseArea

                anchors.fill: parent

                acceptedButtons: Qt.LeftButton | Qt.RightButton
                drag.target:     stage

                onClicked:
                {
                    if (mouse.button == Qt.RightButton)
                    {
                        menu.open();
                    }
                }
            }

            // Close-button
            Item
            {
                id: icon

                anchors.verticalCenter: label.verticalCenter
                anchors.right:          parent.right
                anchors.margins:        Ui.style.paddingMedium

                /*
                icon:       '0272-cross.png'
                iconWidth:  12
                iconHeight: 12

                visible: allowClose
                backgroundVisible: false

                onClicked:
                {
                    stage.closed();
                }
                */
            }
        }
    }

    // Slots
    Item
    {
        id: connectors

        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.bottom: parent.bottom
        implicitWidth:  inputs.implicitWidth + Ui.style.paddingLarge + outputs.implicitWidth
        implicitHeight: Math.max(inputs.implicitHeight, outputs.implicitHeight) + Ui.style.paddingLarge

        // Input slots
        Column
        {
            id: inputs

            anchors.left: parent.left
            spacing:      Ui.style.paddingSmall
        }

        // Output slots
        Column
        {
            id: outputs

            anchors.right: parent.right
            spacing:       Ui.style.paddingSmall
        }
    }

    /**
    *  Component that contains the template for an input slot
    */
    property Component inputSlotComponent : InputSlot
    {
        properties:  stage.properties
        showEditors: !stage.inverse

        hovered:  (pipeline != null && pipeline.hoveredPath == path && pipeline.hoveredSlot == slot)

        onEntered:
        {
            pipeline.onSlotEntered(path, slot);
        }

        onExited:
        {
            pipeline.onSlotExited(path, slot);
        }

        onPressed:
        {
            if (connectable)
            {
                pipeline.onInputSelected(path, slot);
            }
        }
    }

    /**
    *  Component that contains the template for an output slot
    */
    property Component outputSlotComponent: OutputSlot
    {
        properties:  stage.properties
        showEditors: stage.inverse

        hovered:  (pipeline != null && pipeline.hoveredPath == path && pipeline.hoveredSlot == slot)

        onEntered:
        {
            pipeline.onSlotEntered(path, slot);
        }

        onExited:
        {
            pipeline.onSlotExited(path, slot);
        }

        onPressed:
        {
            pipeline.onOutputSelected(path, slot);
        }
    }

    /**
    *  Clear stage
    */
    function clear()
    {
        // Destroy all inputs
        for (var i in inputs.children)
        {
            var slot = inputs.children[i];
            slot.destroy();
        }

        // Destroy all outputs
        for (var i in outputs.children)
        {
            var slot = outputs.children[i];
            slot.destroy();
        }

        // Reset item cache
        slotItems = {};
    }

    /**
    *  Load stage from pipeline interface
    */
    function update()
    {
        clear();

        if (path == '') {
            return;
        }

        // Get stage
        var stageDesc = properties.getStage(path);

        if (includeInputs)
        {
            var component  = inverse ? outputSlotComponent : inputSlotComponent;
            var parentItem = inverse ? outputs : inputs;

            for (var i in stageDesc.inputs)
            {
                var inputName = stageDesc.inputs[i];

                var slotStatus = properties.getSlot(path, inputName);

                var slotItem = component.createObject(parentItem, {
                    path: path,
                    slot: inputName,
                    status: slotStatus
                } );

                slotItems[inputName] = { type: inverse ? 'output' : 'input', item: slotItem };
            }
        }

        if (includeOutputs)
        {
            var component  = inverse ? inputSlotComponent : outputSlotComponent;
            var parentItem = inverse ? inputs : outputs;

            for (var i in stageDesc.outputs)
            {
                var outputName = stageDesc.outputs[i];

                var slotStatus = properties.getSlot(path, outputName);

                var slotItem = component.createObject(parentItem, {
                    path: path,
                    slot: outputName,
                    status: slotStatus
                } );

                slotItems[outputName] = { type: inverse ? 'input' : 'output', item: slotItem };
            }
        }
    }

    /**
    *  Get position of slot in stage
    *
    *  @param[in] name
    *    Name of slot
    */
    function getSlotPos(name)
    {
        var slot = slotItems[name];

        if (slot && slot.item)
        {
            if (slot.type == 'input')
            {
                return slot.item.mapToItem(stage, 0, slot.item.height / 2.0);
            }
            else if (slot.type == 'output')
            {
                return slot.item.mapToItem(stage, slot.item.width, slot.item.height / 2.0);
            }
        }

        return null;
    }

    /**
    *  Load pipeline
    */
    onPathChanged:
    {
        update();
    }
}
