
import QtQuick 2.0

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0


/**
*  PipelineEditor
*
*  Dialog for editing a pipeline
*/
Rectangle
{
    id: panel

    // Options
    property var properties: null ///< Interface for communicating with the actual properties

    // Internals
    property bool loaded: false

    implicitWidth:  scrollArea.contentWidth  + 20
    implicitHeight: scrollArea.contentHeight + 20

    ScrollArea
    {
        id: scrollArea

        anchors.fill: parent

        contentWidth:  pipeline.width
        contentHeight: pipeline.height

        Pipeline
        {
            id: pipeline

            anchors.top:  parent.top
            anchors.left: parent.left

            properties: panel.properties
        }
    }

    /**
    *  Load pipeline
    *
    *  @param[in] root
    *    Pipeline object
    */
    function load(root)
    {
        // Check if pipeline has already been loaded
        if (!loaded)
        {
            // Set pipeline root
            pipeline.path = root || 'root';

            // Done
            loaded = true;
        }
    }

    /**
    *  Update pipeline (reload on different model)
    */
    function update()
    {
        pipeline.path = "";
        pipeline.path = "root";
    }
}
