
import QtQuick 2.0
import QtQuick.Layouts 1.1

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0
import QmlToolbox.PipelineEditor 1.0 as Editor


Page 
{
    id: page

    header: ToolBar 
    {
        id: toolBar

        RowLayout 
        {
            anchors.fill: parent

            ToolButton 
            {
                text: qsTr("Back")

                onClicked: page.StackView.view.pop()
            }

            Item
            {
                Layout.fillWidth: true
            }
        }
    }

    Editor.PipelineEditor
    {
        id: pipelineEditor

        anchors.fill: parent

        pipelineInterface: DemoPipelineInterface
        {
        }
    }

    Component.onCompleted:
    {
        pipelineEditor.load();
    }
}
