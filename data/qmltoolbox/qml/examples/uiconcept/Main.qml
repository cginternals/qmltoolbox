
import QtQuick 2.4
import QtQuick.Layouts 1.3

import QmlToolbox.Base           1.0
import QmlToolbox.Controls       1.0
import QmlToolbox.Components     1.0
import QmlToolbox.PropertyEditor 1.0


ApplicationWindow
{
    id: window

    x:       settings.x
    y:       settings.y
    width:   settings.width
    height:  settings.height
    visible: false

    Shortcut
    {
        sequence: "CTRL+F6"
        onActivated: mainView.sidePanel.toggleVisible()
    }

    Shortcut
    {
        sequence: "CTRL+F7"
        onActivated: bottomPanel.toggleVisible()
    }

    Shortcut
    {
        sequence: "CTRL+F11"
        onActivated: togglePreviewMode();
    }

    Shortcut
    {
        sequence: "F11"
        onActivated: toggleFullScreenMode();
    }

    Shortcut
    {
        sequence: "ALT+RETURN"
        onActivated: toggleFullScreenMode();
    }

    Item
    {
        id: stateWrapper

        state: "normal"

        states:
        [
            State
            {
                name: "preview"

                StateChangeScript { script: mainView.hideAllTools() }
                StateChangeScript { script: bottomPanel.setVisible(false) }
                StateChangeScript { script: header.tabBar.currentIndex = 0 }

                PropertyChanges
                {
                    target: window
                    header: null
                }
            },

            State
            {
                name: "normal"

                StateChangeScript { script: mainView.unhideAllTools() }
            }
        ]
    }

    Item
    {
        id: fsStateWrapper

        state: "windowedMode"

        states:
        [
            State
            {
                name: "windowedMode"

                StateChangeScript { script: window.showNormal() }
            },

            State
            {
                name: "fullScreenMode"

                StateChangeScript { script: window.showFullScreen() }
            }
        ]
    }

    function togglePreviewMode()
    {
        stateWrapper.state = (stateWrapper.state == "normal") ? "preview" : "normal";
    }

    function toggleFullScreenMode()
    {
        fsStateWrapper.state = (fsStateWrapper.state == "windowedMode") ? "fullScreenMode" : "windowedMode";
    }

    header: Header
    {
        id: header
    }

    // Container for the main view(s)
    Item
    {
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.top:    parent.top
        anchors.bottom: bottomPanel.top

        StackLayout
        {
            id: stackLayout
            anchors.fill: parent
            currentIndex: header.tabBar.currentIndex

            // Main view
            MainView
            {
                id: mainView

                anchors.fill: parent
            }

            // Pipeline view
            PipelineView
            {
                id: pipelineView

                anchors.fill: parent

                properties: demoProperties

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

                onClosed:
                {
                    header.tabBar.currentIndex = 0;
                }
            }
        }
    }

    PipelineSelection
    {
        id: pipelineSelection
        visible: false
    }

    SettingsDialog
    {
        id: settingsDialog
        settings: settings
    }

    // Bottom Panel
    BottomPanel
    {
        id: bottomPanel
        visible: false
    }

    // Output capturing
    MessageForwarder
    {
        id: message_forwarder

        onMessageReceived:
        {
            // Put message on console log
            bottomPanel.scriptConsole.output(message, type);
        }
    }

    // Connection to properties
    DemoPropertyInterface
    {
        id: demoProperties
    }

    // Application settings
    Settings
    {
        id: settings

        property int    x:             100
        property int    y:             100
        property int    width:         800
        property int    height:        600
        property bool   debugMode:     false
        property string panelPosition: 'left'

        onDebugModeChanged:
        {
            Ui.debugMode = debugMode;
        }
    }

    ConceptStyle
    {
        id: alteredStyle
    }

    Component.onCompleted:
    {
        settings.load();
        window.visible = true;
        Ui.style = alteredStyle
    }

    Component.onDestruction:
    {
        settings.x      = x;
        settings.y      = y;
        settings.width  = width;
        settings.height = height;
    }
}
