
import QtQuick 2.4

import QmlToolbox.Controls 1.0 as Controls


Item 
{
    id: item

    property var    pipelineInterface: null ///< Interface for communicating with the actual pipeline
    property string path:              ''   ///< Path to pipeline slot (e.g., 'pipeline.Stage1.in1')

    implicitWidth:  input.implicitWidth
    implicitHeight: input.implicitHeight

    Controls.Slider 
    {
        id: input

        anchors.fill: parent

        from: 0; to: 2

        onValueChanged: pipelineInterface.setSlotValue(path, value);
    }

    function update() 
    {
        var slotInfo = pipelineInterface.getSlot(path);
        input.value = slotInfo.value;
    }
}
