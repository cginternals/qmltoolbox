
import QtQuick 2.7
import QtQuick.Layouts 1.3

import QmlToolbox.Controls2 1.0 as Controls


Controls.Pane {
    id: item

    property var    pipelineInterface: null ///< Interface for communicating with the actual pipeline
    property string path:              ''   ///< Path to pipeline or stage (e.g., 'pipeline')
    
    property var properties: []

    ColumnLayout {
        anchors.fill: parent

        spacing: 20

        Repeater {
            model: item.properties

            delegate: ValueEdit {
                pipelineInterface: item.pipelineInterface
                path: item.path + '.' + modelData

                onPathChanged: update();
            }
        }
    }

    function update() {
        // Get stage info
        var stage = pipelineInterface.getStage(path);

        var num = stage.inputs.length || 0;

        console.log("stage.inputs: " + stage.inputs);

        var names = [];

        for (var i=0; i<num; i++) {
            names.push(stage.inputs[i]);
        }

        item.properties = names;
    }
}
