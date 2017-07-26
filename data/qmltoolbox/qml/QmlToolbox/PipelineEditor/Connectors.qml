
import QtQuick 2.0

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0


/**
*  Connectors
*
*  Draws the connections between stages
*/
Item
{
    id: connectors

    // Options
    property var    properties: null ///< Interface for accessing the pipeline
    property Item   pipeline:   null ///< Pointer to pipeline item
    property string path:       ''   ///< Path in the pipeline hierarchy (e.g., 'pipeline')
    property int    arrowSize:  Ui.style.pipelineSlotSize / 3.0

    // 2D canvas for drawing
    Canvas
    {
        id: canvas

        anchors.fill: parent

        antialiasing: true

        /**
        *  Draw on canvas
        */
        onPaint:
        {
            // Get draw context
            var ctx = canvas.getContext('2d');

            // Clear canvas
            ctx.clearRect(0, 0, width, height);

            // Draw connectors
            drawConnectors(ctx);
        }

        /**
        *  Draw all connectors of the given pipeline
        *
        *  @param[in] ctx
        *    Draw context
        */
        function drawConnectors(ctx)
        {
            // Utility functions to get the path and the slot name
            var getPath = function (path) {
                var splitPath = path.split('.');
                splitPath.splice(splitPath.length - 1, 1);
                return splitPath.join('.');
            };
            var getSlot = function (path) {
                var splitPath = path.split('.');
                return splitPath[splitPath.length - 1];
            };
            var isEqual = function (path, slot, combinedPath) {
                return path == getPath(combinedPath) && slot == getSlot(combinedPath);
            }

            // Get all stages of the pipeline and the pipeline itself
            var stages = [];

            stages.push(path);

            var pipelineInfo = properties.getStage(path);

            for (var i in pipelineInfo.stages)
            {
                stages.push(path + '.' + pipelineInfo.stages[i]);
            }

            // Get connectors
            var pipeline = connectors.pipeline;
            for (var i in stages)
            {
                // Get stage
                var stage = stages[i];

                // Get connections of the stage
                var connections = properties.getConnections(stage);
                for (var j in connections)
                {
                    // Get connection
                    var connection = connections[j];
                    var from = connection.from;
                    var to   = connection.to;

                    // Draw connection
                    var p0 = pipeline.getSlotPos(getPath(from), getSlot(from));
                    var p1 = pipeline.getSlotPos(getPath(to), getSlot(to));

                    if (p0 != null && p1 != null)
                    {
                        // Highlight the connection if its input or output slot is selected
                        var status = 0;
                        if (isEqual(pipeline.hoveredPath, pipeline.hoveredSlot, from) ||
                            isEqual(pipeline.hoveredPath, pipeline.hoveredSlot, to))
                        {
                            status = 1;
                        }

                        drawConnector(ctx, p0, p1, status);
                    }
                }
            }

            // Draw interactive connector
            if (pipeline.selectedOutput != '')
            {
                var p0 = pipeline.getSlotPos(pipeline.selectedPath, pipeline.selectedOutput);
                var p1 = { x: pipeline.mouseX, y: pipeline.mouseY };
                drawConnector(ctx, p0, p1, 2);
            }

            if (pipeline.selectedInput != '')
            {
                var p0 = { x: pipeline.mouseX, y: pipeline.mouseY };
                var p1 = pipeline.getSlotPos(pipeline.selectedPath, pipeline.selectedInput);
                drawConnector(ctx, p0, p1, 2);
            }
        }

        /**
        *  Draw a connector
        *
        *  @param[in] ctx
        *    Draw context
        *  @param[in] p0
        *    Start position (x, y)
        *  @param[in] p1
        *    End position (x, y)
        *  @param[in] status
        *    Connector state (0: normal, 1: highlighted, 2: selected)
        */
        function drawConnector(ctx, p0, p1, status)
        {
            var x0 = p0.x;
            var y0 = p0.y;
            var x1 = p1.x;
            var y1 = p1.y;

            var color = Ui.style.pipelineLineColorDefault;
            if (status == 1) color = Ui.style.pipelineLineColorHighlighted;
            if (status == 2) color = Ui.style.pipelineLineColorSelected;

            ctx.strokeStyle = color;
            ctx.fillStyle   = color;
            ctx.lineWidth   = 2;

            ctx.beginPath();
            ctx.moveTo(x0, y0);
            ctx.bezierCurveTo(x0, y0, x0 + 100, y0, (x0 + x1) / 2.0, (y0 + y1) / 2.0);
            ctx.bezierCurveTo((x0 + x1) / 2.0, (y0 + y1) / 2.0, x1 - 100, y1, x1, y1);
            ctx.stroke();

            ctx.beginPath();
            ctx.moveTo(x1, y1);
            ctx.lineTo(x1 - arrowSize, y1 - arrowSize);
            ctx.lineTo(x1 - arrowSize, y1 + arrowSize);
            ctx.lineTo(x1, y1);
            ctx.fill();
        }
    }

    /**
    *  Request redraw
    */
    function requestPaint()
    {
        canvas.requestPaint();
    }
}
