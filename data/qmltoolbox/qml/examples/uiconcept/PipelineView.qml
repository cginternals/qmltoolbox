
import QtQuick 2.0

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0
import QmlToolbox.PipelineEditor 1.0


Item
{
    id: page

    signal closed()

    property var properties: null ///< Interface for communicating with the actual properties

    implicitWidth:  pipelineEditor.implicitWidth
    implicitHeight: pipelineEditor.implicitHeight

    PipelineEditor
    {
        id: pipelineEditor

        anchors.fill: parent

        properties: page.properties

        LabelButton
        {
            text: 'Close'

            anchors.top:     parent.top
            anchors.left:    parent.left
            anchors.margins: Ui.style.paddingMedium

            onClicked:
            {
                page.closed();
            }
        }

        LabelButton
        {
            text: "Show Console"
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.bottomMargin: 8

            visible: !bottomPanel.isVisible()

            onClicked: bottomPanel.setVisible(true)
        }
    }

    Component.onCompleted:
    {
        pipelineEditor.load();
    }
}
