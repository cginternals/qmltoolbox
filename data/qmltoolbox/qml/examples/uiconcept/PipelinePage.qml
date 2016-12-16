
import QtQuick 2.7
import QtQuick.Layouts 1.3

import QtQuick.Controls 2.0

import QmlToolbox.Base 1.0
import QmlToolbox.PipelineEditor 1.0
import QmlToolBox.Controls2 1.0 as Controls

Page {
    id: page

    header: Controls.ToolBar {
        id: toolBar

        RowLayout {
            anchors.fill: parent

            Controls.ToolButton {
                text: qsTr("Back")

                onClicked: page.StackView.view.pop()
            }

            Item { Layout.fillWidth: true }
        }
    }

    PipelineEditor
    {
        id: pipelineEditor

        anchors.fill: parent

        pipelineInterface: DemoPipelineInterface { }
    }

    Component.onCompleted:
    {
        Ui.setStyle("Light");
        pipelineEditor.load();
    }
}