
import QtQuick 2.0


/**
*  PipelineInterface
*
*  Generic interface for accessing a pipeline.
*  This interface can be implemented to access any type of pipeline.
*  The current implementation uses the gloperate pipeline as a backend.
*/
Item
{
    id: pipelineInterface

    /**
    *  Get list of available stage types
    *
    *  @return
    *    [ 'StageType1', 'StageType2', ... ]
    */
    function getStageTypes()
    {
        return [];
    }

    /**
    *  Get information of a stage
    *
    *  @param[in] path
    *    Path to stage (e.g., 'pipeline.stage1')
    *
    *  @return
    *    {
    *      name: 'StageName',
    *      inputs:  [ 'Input1',  ... ],
    *      outputs: [ 'Output1', ... ],
    *      stages:  [ 'Child1',  ... ]
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
    *  Get information of a slot
    *
    *  @param[in] path
    *    Path to slot (e.g., 'pipeline.stage1.in1')
    *
    *  @return
    *    {
    *      name:    'SlotName',
    *      type:    'int',
    *      value:   100,
    *      options: {}
    *    }
    */
    function getSlot(path)
    {
        return {
            name:    '',
            type:    '',
            value:   null,
            options: {}
        };
    }

    /**
    *  Set slot value
    *
    *  @param[in] path
    *    Path to slot (e.g., 'pipeline.stage1.in1')
    *  @param[in] value
    *    Value
    */
    function setSlotValue(path, value)
    {
    }

    /**
    *  Create new stage
    *
    *  @param[in] path
    *    Path to pipeline (e.g., 'pipeline')
    *  @param[in] className
    *    Type of stage
    *  @param[in] name
    *    Desired name
    *
    *  @return
    *    Actual name of new stage
    */
    function createStage(path, className, name)
    {
        return '';
    }

    /**
    *  Remove stage from pipeline
    *
    *  @param[in] path
    *    Path to pipeline (e.g., 'pipeline')
    *  @param[in] name
    *    Stage name
    */
    function removeStage(path, name)
    {
    }

    /**
    *  Get types of slots that can be created on a stage
    *
    *  @param[in] path
    *    Path to stage (e.g., 'pipeline.stage1')
    *
    *  @return
    *    Array of available slot types
    */
    function getSlotTypes(path)
    {
        return [];
    }

    /**
    *  Create slot on stage
    *
    *  @param[in] path
    *    Path to stage (e.g., 'pipeline.stage1')
    *  @param[in] slotType
    *    Slot type ('input' or 'output')
    *  @param[in] type
    *    Type (see getSlotTypes())
    *  @param[in] name
    *    Name of slot
    */
    function createSlot(path, slotType, type, name)
    {
    }

    /**
    *  Get connections of slots on a stage
    *
    *  @param[in] path
    *    Path to stage (e.g., 'pipeline.stage1')
    *
    *  @return
    *    Array of connections ( e.g., [ { from: 'pipeline.stage1.out1', to: 'pipeline.stage2.in3' }, ... ] )
    */
    function getConnections(path)
    {
        return [];
    }

    /**
    *  Create connection between slots
    *
    *  @param[in] from
    *    Path to slot (e.g., 'pipeline.stage1.out1')
    *  @param[in] to
    *    Path to slot (e.g., 'pipeline.stage2.in1')
    */
    function createConnection(from, to)
    {
    }

    /**
    *  Remove connection between slots
    *
    *  @param[in] to
    *    Path to slot (e.g., 'pipeline.stage2.in1')
    */
    function removeConnection(to)
    {
    }
}
