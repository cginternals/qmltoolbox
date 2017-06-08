
import QtQuick 2.0


/**
*  PropertyInterface
*
*  Abstract interface for accessing properties and/or pipelines.
*  This interface can be implemented to access any type of pipeline.
*/
Item
{
    id: propertyInterface

    // Must be called when a slot has been changed (either its value or its options)
    signal slotChanged(string path, string slot, var status)

    /**
    *  Get list of available stage types
    *
    *  @return
    *    Array of stage types, e.g.: [ 'StageType1', 'StageType2', ... ]
    */
    function getStageTypes()
    {
        return [];
    }

    /**
    *  Get types of slots that can be created on a stage
    *
    *  @param[in] path
    *    Path to stage (e.g., 'root.stage1')
    *
    *  @return
    *    Array of slot types, e.g.: [ 'int', 'string' ]
    */
    function getSlotTypes(path)
    {
        return [];
    }

    /**
    *  Create new stage
    *
    *  @param[in] path
    *    Path to pipeline (e.g., 'root')
    *  @param[in] stage
    *    Stage name
    *  @param[in] type
    *    Type of stage
    *
    *  @return
    *    Actual name of new stage
    */
    function createStage(path, slot, type)
    {
        return '';
    }

    /**
    *  Remove stage from pipeline
    *
    *  @param[in] path
    *    Path to pipeline (e.g., 'root')
    *  @param[in] stage
    *    Stage name
    */
    function removeStage(path, stage)
    {
    }

    /**
    *  Create slot on stage
    *
    *  @param[in] path
    *    Path to stage (e.g., 'root.stage1')
    *  @param[in] slot
    *    Name of slot (e.g., 'slot1')
    *  @param[in] slotType
    *    Slot type ('input' or 'output')
    *  @param[in] type
    *    Type (see getSlotTypes())
    */
    function createSlot(path, slot, slotType, type)
    {
    }

    /**
    *  Get connections of slots on a stage
    *
    *  @param[in] path
    *    Path to stage (e.g., 'root')
    *
    *  @return
    *    Array of connections ( e.g., [ { from: 'root.stage1.out1', to: 'root.stage2.in3' }, ... ] )
    */
    function getConnections(path)
    {
        return [];
    }

    /**
    *  Create connection between slots
    *
    *  @param[in] sourcePath
    *    Path to stage (e.g., 'root')
    *  @param[in] sourceSlot
    *    Slot name (e.g., 'input1')
    *  @param[in] destPath
    *    Path to stage (e.g., 'root.stage1')
    *  @param[in] destSlot
    *    Slot name (e.g., 'input2')
    */
    function createConnection(sourcePath, sourceSlot, destPath, destSlot)
    {
    }

    /**
    *  Remove connection between slots
    *
    *  @param[in] path
    *    Path to stage (e.g., 'root.stage1')
    *  @param[in] slot
    *    Slot name (e.g., 'input2')
    */
    function removeConnection(path, slot)
    {
    }

    /**
    *  Get information about a stage
    *
    *  @param[in] path
    *    Path to stage (e.g., 'root.stage1')
    *
    *  @return
    *    {
    *      name: 'StageName',
    *      inputs:  [ 'input1',  ... ],
    *      outputs: [ 'output1', ... ],
    *      stages:  [ 'stage1',  ... ]
    *    }
    */
    function getStage(path)
    {
        return {
            name:    '',
            inputs:  [],
            outputs: [],
            stages:  []
        };
    }

    /**
    *  Get information about a slot
    *
    *  @param[in] path
    *    Path to stage (e.g., 'root.stage1')
    *  @param[in] slot
    *    Slot name (e.g., 'input1')
    *
    *  @return
    *    e.g.: {
    *      name:  'number',
    *      type:  'int',
    *      value: 0,
    *      minimumValue: 0,
    *      maximumValue: 1000
    *    }
    */
    function getSlot(path, slot)
    {
        return {
            name: 'number',
            type: 'int',
            value: 0,
            minimumValue: 0,
            maximumValue: 100
        };
    }

    /**
    *  Get slot value
    *
    *  @param[in] path
    *    Path to stage (e.g., 'root.stage1')
    *  @param[in] slot
    *    Slot name (e.g., 'input1')
    *
    *  @return
    *    Slot value
    */
    function getValue(path, slot)
    {
        return 0;
    }

    /**
    *  Set slot value
    *
    *  @param[in] path
    *    Path to stage (e.g., 'root.stage1')
    *  @param[in] slot
    *    Slot name (e.g., 'input1')
    *  @param[in] value
    *    Slot value
    */
    function setSlotValue(path, slot, value)
    {
    }
}
