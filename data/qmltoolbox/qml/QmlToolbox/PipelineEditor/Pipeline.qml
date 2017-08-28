
import QtQuick 2.0
import QtQuick.Controls 1.1

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0


/**
*  Pipeline
*
*  Representation of a pipeline
*/
Item
{
    id: pipeline

    signal stageCreated(string path) ///< Signals creation of a new stage item after the pipeline was loaded

    // Options
    property var    properties: null ///< Interface for accessing the actual properties
    property string path:       ''   ///< Path in the pipeline hierarchy (e.g., 'pipeline')

    // Internals
    property var    stageItems:     null ///< Item cache
    property string hoveredPath:    ''   ///< Path of slot that is currently hovered
    property string hoveredSlot:    ''   ///< Name of slot that is currently hovered
    property string selectedPath:   ''   ///< Path of selected slot ('' if none)
    property string selectedInput:  ''   ///< Name of selected input slot ('' if none)
    property string selectedOutput: ''   ///< Name of selected output slot ('' if none)
    property int    mouseX:         0;   ///< Current mouse position (X component)
    property int    mouseY:         0;   ///< Current mouse position (Y component)

    width:  stages.width
    height: stages.height

    /**
    *  Component that contains the template for a stage
    */
    property Component stageComponent: Stage
    {
        onXChanged: connectors.requestPaint();
        onYChanged: connectors.requestPaint();
    }

    /**
    *  Item for drawing the connectors
    */
    Connectors
    {
        id: connectors

        width:  stages.width
        height: stages.height

        properties: pipeline.properties
        path:       pipeline.path
        pipeline:   pipeline
    }

    // Main menu
    Menu
    {
        id: menu

        title: 'Pipeline'

        MenuItem
        {
            text: 'Add Stage...'

            onTriggered:
            {
                stageAdditionMenu.x = menu.x;
                stageAdditionMenu.y = menu.y;

                stageAdditionMenu.initialize();
                stageAdditionMenu.open();
            }
        }
    }

    // Menu for stage addition
    Menu
    {
        id: stageAdditionMenu

        property bool initialized: false

        function initialize()
        {
            if (initialized)
            {
                return;
            }

            var types = properties.getStageTypes();
            for (var i in types)
            {
                var type = types[i];

                var item = stageAdditionMenu.addMenuItem(type);

                var callbackFactory = function(type)
                {
                    return function()
                    {
                        pipeline.createStage(type, type, menu.x, menu.y);
                    };
                };

                item.triggered.connect(callbackFactory(type));
            }

            initialized = true;
        }
    }


    /**
    *  Background mouse area
    */
    MouseArea
    {
        anchors.fill: parent

        acceptedButtons: Qt.LeftButton | Qt.RightButton
        hoverEnabled:    true

        onClicked:
        {
            // Deselect slots
            if (mouse.button == Qt.LeftButton)
            {
                pipeline.selectedPath   = '';
                pipeline.selectedInput  = '';
                pipeline.selectedOutput = '';
                connectors.requestPaint();
            }

            // Open context menu
            if (mouse.button == Qt.RightButton)
            {
                menu.x = mouse.x;
                menu.y = mouse.y;
                menu.open();
            }
        }

        onPositionChanged:
        {
            // Update mouse position
            pipeline.mouseX = mouse.x;
            pipeline.mouseY = mouse.y;

            // Draw new connection
            if (pipeline.selectedPath != '')
            {
                connectors.requestPaint();
            }
        }
    }

    /**
    *  Item that contains the stages
    */
    Item
    {
        id: stages

        width:  childrenRect.x + childrenRect.width
        height: childrenRect.y + childrenRect.height
    }

    /**
    *  Load pipeline
    */
    onPathChanged:
    {
        // Clear old pipeline
        clearItems();

        // Exit if no pipeline is set
        if (path == '') {
            return;
        }

        // Get pipeline
        var pipelineDesc = properties.getStage(pipeline.path);

        // Add stages
        var x = 250;
        var y = 150;

        for (var i in pipelineDesc.stages)
        {
            var name = pipelineDesc.stages[i];

            var stage = addStageItem(pipeline.path + '.' + name, name, x, y);

            x += stage.width + 250;
        }

        // Add pseudo stages for inputs and outputs of the pipeline itself
        addInputStageItem (pipeline.path, 'Inputs',  20, 150);
        addOutputStageItem(pipeline.path, 'Outputs', x,  150);

        // Hack: layout after 5 ms to ensure loading of stages is finished
        function Timer() {
            return Qt.createQmlObject("import QtQuick 2.0; Timer {}", pipeline);
        }
        function delay(delayTime, cb) {
            var timer = new Timer();
            timer.interval = delayTime;
            timer.repeat = false;
            timer.triggered.connect(cb);
            timer.start();
        }
        delay(10, function() {
            computeLayout();
        });

        // Redraw connections
        connectors.requestPaint();
    }

    /**
    *  Clear all items in the pipeline editor
    */
    function clearItems()
    {
        // Destroy all stages
        for (var i=0; i<stages.children.length; i++)
        {
            var stage = stages.children[i];
            stage.destroy();
        }

        // Reset item cache
        stageItems = {};
    }

    /**
    *  Add item for stage
    *
    *  @param[in] path
    *    Path in the pipeline hierarchy
    *  @param[in] name
    *    Name of stage
    *  @param[in] x
    *    X-position
    *  @param[in] y
    *    Y-position
    */
    function addStageItem(path, name, x, y)
    {
        // Create item for stage
        var stage = stageComponent.createObject(
            stages,
            {
                properties: properties,
                pipeline:   pipeline,
                x:          x || 100,
                y:          y || 100,
                name:       name || 'Stage'
            }
        );

        // Load stage
        stage.path = path;

        // Add to item cache
        stageItems[name] = stage;

        // Connect signal to remove the stage
        stage.closed.connect(function()
        {
            removeStage(path, name);
        });

        // Return item
        return stage;
    }

    /**
    *  Add item for input-stage
    *
    *  @param[in] path
    *    Path in the pipeline hierarchy
    *  @param[in] name
    *    Name of stage
    *  @param[in] x
    *    X-position
    *  @param[in] y
    *    Y-position
    */
    function addInputStageItem(path, name, x, y)
    {
        // Create item for stage
        var stage = stageComponent.createObject(
            stages,
            {
                properties:     properties,
                pipeline:       pipeline,
                x:              x || 100,
                y:              y || 100,
                name:           name,
                color:          Ui.style.pipelineTitleColor2,
                includeInputs:  true,
                includeOutputs: false,
                inverse:        true,
                allowClose:     false
            }
        );

        // Load stage
        stage.path = path;

        // Add to item cache
        stageItems[name] = stage;

        // Return item
        return stage;
    }

    /**
    *  Add item for output-stage
    *
    *  @param[in] path
    *    Path in the pipeline hierarchy
    *  @param[in] name
    *    Name of stage
    *  @param[in] x
    *    X-position
    *  @param[in] y
    *    Y-position
    */
    function addOutputStageItem(path, name, x, y)
    {
        // Create item for stage
        var stage = stageComponent.createObject(
            stages,
            {
                properties:     properties,
                pipeline:       pipeline,
                x:              x || 100,
                y:              y || 100,
                name:           name,
                color:          Ui.style.pipelineTitleColor2,
                includeInputs:  false,
                includeOutputs: true,
                inverse:        true,
                allowClose:     false
            }
        );

        // Load stage
        stage.path = path;

        // Add to item cache
        stageItems[name] = stage;

        // Return item
        return stage;
    }

    /**
    *  Create new stage in pipeline
    *
    *  @param[in] path
    *    Path of pipeline
    *  @param[in] className
    *    Stage class
    *  @param[in] name
    *    Name of stage
    */
    function createStage(className, name, x, y)
    {
        // Create stage
        var realName = properties.createStage(pipeline.path, className, name);

        // Create stage item
        addStageItem(pipeline.path + '.' + realName, realName, x, y);

        stageCreated(pipeline.path + '.' + realName);
    }

    /**
    *  Remove stage from pipeline
    *
    *  @param[in] path
    *    Path of pipeline
    *  @param[in] name
    *    Name of stage
    */
    function removeStage(path, name)
    {
        // Remove stage item
        stageItems[name].destroy();
        delete stageItems[name];

        // Destroy stage
        properties.removeStage(pipeline.path, name);

        // Redraw connections
        connectors.requestPaint();
    }

    /**
    *  Compute ranks in half ordered graph
    */
    function computeRanks()
    {
        var getPath = function (path) {
            var splitPath = path.split('.');
            splitPath.splice(splitPath.length - 1, 1);
            return splitPath.join('.');
        };

        // build the empty graph
        var graph = {};
        var inverseGraph = {};
        var pathToName = {};
        for (var name in stageItems)
        {
            graph[stageItems[name].path] = [];
            inverseGraph[stageItems[name].path] = [];
            pathToName[stageItems[name].path] = name;
        }
        pathToName["root"] = "Outputs";

        // insert edges
        for (var name in stageItems)
        {
            var connections = properties.getConnections(stageItems[name].path);
            for (var i in connections)
            {
                var fromPath = getPath(connections[i].from);
                var toPath = getPath(connections[i].to);

                if (fromPath == "root" || connections[i].feedback)
                {
                    // ignore connections from root (inputs will be leftmost)
                    // and feedback connections
                    // this lets the algorithm start at the output node
                    continue;
                }

                if (graph[fromPath].indexOf(toPath) < 0)
                {
                    graph[fromPath].push(toPath);
                }

                if (inverseGraph[toPath].indexOf(fromPath) < 0)
                {
                    inverseGraph[toPath].push(fromPath);
                }
            }
        }

        var ranks = [];
        var toRemove = [];
        while (Object.keys(graph).length > 0)
        {
            for (var path in graph)
            {
                if (graph[path].length === 0)
                {
                    toRemove.push(path);
                }
            }

            if (toRemove.length === 0)
            {
                console.log("circular graph detected, abort layout process.");
                break;
            }

            var names = [];
            for (var i in toRemove)
            {
                names.push(pathToName[toRemove[i]]);

            }
            ranks.push(names);

            for (var i in toRemove)
            {
                var current = toRemove[i];
                for (var j in inverseGraph[current])
                {
                    var predecessor = inverseGraph[current][j];
                    var edgeNum = graph[predecessor].indexOf(current);
                    graph[predecessor].splice(edgeNum, 1);
                }
                delete graph[current];
            }
            toRemove = [];
        }
        ranks.push(["Inputs"]);

        return ranks;
    }

    /**
    *  Compute automatic layout for stages
    */
    function computeLayout()
    {
        var startX = 120;
        var marginX = 100;
        var startY = 120;
        var marginY = 100;

        var x = startX;

        var ranks = computeRanks();

        for (var i in ranks)
        {
            // go through the computed ranks in reverse order
            var stages = ranks[ranks.length - i - 1];

            var maxWidth = 0;
            for (var j in stages)
            {
                var current = stageItems[stages[j]];

                maxWidth = Math.max(maxWidth, current.width);
            }

            var y = startY;
            for (var j in stages)
            {
                var current = stageItems[stages[j]];

                current.x = x + (maxWidth - current.width) / 2;
                current.y = y;

                y += current.height + marginY;
            }
            x += maxWidth + marginX;
        }

        connectors.requestPaint();
    }

    /**
    *  Get position of slot in pipeline
    *
    *  @param[in] path
    *    Path in pipeline hierarchy (e.g., 'pipeline.stage1')
    *  @param[in] slot
    *    Name of slot (e.g., 'input1')
    */
    function getSlotPos(path, slotName)
    {
        // The path must start with the path to this pipeline, otherwise something is wrong
        var pipelineNames = pipeline.path.split('.');
        var names = path.split('.');
        for (var i = 0; i < pipelineNames.length; i++)
        {
            if (names.length < pipelineNames.length || pipelineNames[i] != names[i])
            {
                // Something is wrong
                return null;
            }
        }

        // Get path relative to the pipeline (remove pipeline path elements)
        names.splice(0, pipelineNames.length);

        // If subpath has elements left, it is a slot on a stage
        if (names.length == 1)
        {
            var stageName = names[0];

            // Get stage
            var stageItem = stageItems[stageName];
            if (stageItem)
            {
                var pos = stageItem.getSlotPos(slotName);
                return stageItem.mapToItem(pipeline, pos.x, pos.y);
            }
        }

        // If subpath has only one component, it is a slot on this pipeline
        else if (names.length == 0)
        {
            // Get stage
            var inputsItem  = stageItems['Inputs'];
            var outputsItem = stageItems['Outputs'];

            if (inputsItem && outputsItem)
            {
                var pos = inputsItem.getSlotPos(slotName);

                if (pos)
                {
                    return inputsItem.mapToItem(pipeline, pos.x, pos.y);
                }

                pos = outputsItem.getSlotPos(slotName);

                if (pos)
                {
                    return outputsItem.mapToItem(pipeline, pos.x, pos.y);
                }
            }
        }

        // Error in calling this function
        return null;
    }

    /**
    *  Called when mouse has entered a slot
    *
    *  @param[in] path
    *    Path in pipeline hierarchy (e.g., 'pipeline.stage1')
    *  @param[in] slot
    *    Name of slot (e.g., 'input1')
    */
    function onSlotEntered(path, slot)
    {
        hoveredPath = path;
        hoveredSlot = slot;

        connectors.requestPaint();
    }

    /**
    *  Called when mouse has left a slot
    *
    *  @param[in] path
    *    Path in pipeline hierarchy (e.g., 'pipeline.stage1')
    *  @param[in] slot
    *    Name of slot (e.g., 'input1')
    */
    function onSlotExited(path, slot)
    {
        if (hoveredPath == path && hoveredSlot == slot)
        {
            hoveredPath = '';
            hoveredSlot = '';
        }

        connectors.requestPaint();
    }

    /**
    *  Called when an input slot has been selected
    *
    *  @param[in] path
    *    Path in pipeline hierarchy (e.g., 'pipeline.stage1')
    *  @param[in] slot
    *    Name of slot (e.g., 'input1')
    */
    function onInputSelected(path, slot)
    {
        // If input slot is already connected, remove connection
        properties.removeConnection(path, slot);

        // Connection created
        if (path != '' && slot != '' && selectedOutput != '')
        {
            // Create connection
            properties.createConnection(selectedPath, selectedOutput, path, slot);

            // Reset selection
            selectedPath   = '';
            selectedInput  = '';
            selectedOutput = '';
        }

        // Select one side
        else
        {
            // Select input slot
            selectedPath   = path;
            selectedInput  = slot;
            selectedOutput = '';
        }

        // Redraw connections
        connectors.requestPaint();
    }

    /**
    *  Called when an output slot has been selected
    *
    *  @param[in] path
    *    Path in pipeline hierarchy (e.g., 'pipeline.stage1')
    *  @param[in] slot
    *    Name of slot (e.g., 'output1')
    */
    function onOutputSelected(path, slot)
    {
        // Connection created
        if (path != '' && slot != '' && selectedInput != '')
        {
            // Create connection
            properties.createConnection(path, slot, selectedPath, selectedInput);

            // Reset selection
            selectedPath   = '';
            selectedInput  = '';
            selectedOutput = '';
        }

        // Select one side
        else
        {
            // Select output slot
            selectedPath   = path;
            selectedInput  = '';
            selectedOutput = slot;
        }

        // Redraw connections
        connectors.requestPaint();
    }
}
