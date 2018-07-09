
import QtQuick 2.0
import QtQuick.Layouts 1.0

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0

ToolBar
{
    readonly property alias tabBar: tabBar

    Rectangle {
        id: headerBackground
        anchors.fill: parent
        color: Ui.style.headlineColor
    }

    RowLayout
    {
        anchors.fill: parent

        spacing: 8

        // left: logo, pipeline title, "load pipeline" button
        Image
        {
            id: logo
            width: parent.height
            height: parent.height
            fillMode: Image.PreserveAspectCrop
            source: "img/logo.svg"
            sourceSize.width: logo.width
            sourceSize.height: logo.height
            smooth: false
        }

        Label
        {
            id: title

            text: demoProperties.stage.name
            font: Ui.style.mainFont
            color: "white"
        }

        LabelButton
        {
            id: loadBtn
            text: "Load pipeline"
            anchors.verticalCenter: parent.verticalCenter

            labelFont: Ui.style.buttonFont
            bgColor: Ui.style.backgroundSignalColor

            onClicked: pipelineSelection.visible = true
        }

        Item
        {
            id: leftSpacer
            Layout.fillWidth: true
        }

        // center: tabs for different views
        TabBar
        {
            id: tabBar

            background: null
            anchors.bottom: parent.bottom
            spacing: 8

            currentIndex: stackLayout.currentIndex

            MyTabButton
            {
                font: Ui.style.mainFont
                text: qsTr("Viewer")
            }

            MyTabButton
            {
                font: Ui.style.mainFont
                text: qsTr("Pipeline")
            }
        }

        Item
        {
            id: rightSpacer
            Layout.fillWidth: true
        }

        // right: buttons for settings & fullscreen
        ToolButton
        {

            contentItem: Image
            {
                source: "icons/ic_settings_white_24px.svg"

                width: 32
                height: 28
            }

            background.visible: false

            onClicked: settingsDialog.open()
        }

        ToolButton
        {
            contentItem: Image
            {
                source: "icons/icon_maximize.svg"

                width: 24
                height: 24
            }

            background.visible: false

            onClicked: window.toggleFullScreenMode()
        }
    }
}