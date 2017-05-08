
import QtQuick 2.4
import QtQuick.Layouts 1.1

import QmlToolbox.Base           1.0
import QmlToolbox.Controls       1.0 as Controls
import QmlToolbox.Components     1.0 as Components
import QmlToolbox.PropertyEditor 1.0 as PropertyEditor

import com.cginternals.qmltoolbox 1.0


Controls.ApplicationWindow
{
    id: window

    visible: true

    x:      settings.x
    y:      settings.y
    width:  settings.width
    height: settings.height

    Controls.Shortcut
    {
        sequence: "CTRL+F6"
        onActivated: sidePanel.toggleVisible()
    }

    Controls.Shortcut
    {
        sequence: "CTRL+F7"
        onActivated: bottomPanel.toggleVisible()
    }

    Controls.Shortcut
    {
        sequence: "CTRL+F11"
        onActivated: togglePreviewMode();
    }

    Controls.Shortcut
    {
        sequence: "F11"
        onActivated: toggleFullScreenMode();
    }

    Controls.Shortcut
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

                StateChangeScript { script: sidePanel.setVisible(false) }
                StateChangeScript { script: bottomPanel.setVisible(false) }

                PropertyChanges
                {
                    target: window
                    header: null
                }

                PropertyChanges
                {
                    target:  mainMenu
                    visible: false
                }
            },

            State
            {
                name: "normal"

                StateChangeScript { script: sidePanel.setVisible(true) }
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

    header: Controls.ToolBar
    {
        id: toolBar

        RowLayout
        {
            anchors.fill: parent

            Controls.ToolButton
            {
                text: qsTr("Menu")
                onClicked: mainMenu.open()
            }

            Item { Layout.fillWidth: true }

            Controls.ToolButton
            {
                text: qsTr("Pipeline")
                onClicked: pipelineMenu.open()

                Controls.Menu {
                    id: pipelineMenu
                    y: toolBar.height

                    Controls.MenuItem { text: qsTr("Edit Pipeline") }
                }
            }

            Controls.ToolButton
            {
                text: qsTr("Tools")
                onClicked: toolsMenu.open()

                Controls.Menu
                {
                    id: toolsMenu
                    y: toolBar.height

                    Controls.MenuItem { text: qsTr("Take Screenshot") }
                    Controls.MenuItem { text: qsTr("Record Video") }
                }
            }

            Controls.ToolButton
            {
                text: qsTr("View")
                onClicked: viewMenu.open()

                Controls.Menu
                {
                    id: viewMenu
                    y: toolBar.height

                    Controls.MenuItem
                    {
                        text: sidePanel.isVisible() ? qsTr("Hide Side Panel") : qsTr("Show Side Panel")
                        onTriggered: sidePanel.toggleVisible()
                    }

                    Controls.MenuItem
                    {
                        text: bottomPanel.isVisible() ? qsTr("Hide Console") : qsTr("Show Console")
                        onTriggered: bottomPanel.toggleVisible()
                    }

                    Controls.MenuItem
                    {
                        text: sidePanel.isVisible() ? qsTr("Hide All") : qsTr("Show All")

                        onTriggered:
                        {
                            var visible = sidePanel.isVisible();
                            sidePanel  .setVisible(!visible);
                            bottomPanel.setVisible(!visible);
                        }
                    }
                }
            }

            Controls.ToolButton
            {
                text: qsTr("Debug")
                onClicked: Ui.debugMode = !Ui.debugMode
            }

            Controls.ToolButton
            {
                text: (fsStateWrapper.state == "windowedMode") ? qsTr("Fullscreen") : qsTr("Windowed")
                onClicked: window.toggleFullScreenMode()
            }
        }
    }

    MainMenu
    {
        id: mainMenu
    }

    // Wrapper containing main page and side panel
    Item
    {
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.top:    parent.top
        anchors.bottom: bottomPanel.top

        // Main page
        Rectangle
        {
            anchors.left:   parent.left
            anchors.right:  sidePanel.left
            anchors.top:    parent.top
            anchors.bottom: parent.bottom

            color: Ui.style.backgroundColor
        }

        // Side Panel
        Controls.Panel
        {
            id: sidePanel

            position:    'right'
            minimumSize: 240

            Controls.ScrollArea
            {
                anchors.fill: parent

                contentHeight: propertyEditor.height
                contentWidth:  propertyEditor.width

                flickableDirection: Flickable.VerticalFlick
                boundsBehavior: Flickable.StopAtBounds

                PropertyEditor.PropertyEditor
                {
                    id: propertyEditor

                    pipelineInterface: propertyInterface
                    path:              'root'

                    Component.onCompleted:
                    {
                        propertyEditor.update()
                    }
                }
            }

            DemoPropertyInterface
            {
                id: propertyInterface
            }
        }
    }

    // Bottom Panel
    Controls.Panel
    {
        id: bottomPanel

        position:    'bottom'
        minimumSize: 150
        visible:     false

        Components.ScriptConsole
        {
            id: scriptConsole

            anchors.fill: parent

            keywords: ["console", "Math", "Date", "if", "for", "while", "function", "exit"]

            onSubmitted:
            {
                scriptConsole.output("> " + command + "\n", "Command");
                var res = eval(command);

                if (res != undefined)
                {
                    console.log(res);
                }
            }
        }
    }

    MessageForwarder
    {
        id: message_forwarder

        onMessageReceived:
        {
            var stringType;

            if (type == MessageForwarder.Debug)
                stringType = "Debug";
            else if (type == MessageForwarder.Warning)
                stringType = "Warning";
            else if (type == MessageForwarder.Critical)
                stringType = "Critical";
            else if (type == MessageForwarder.Fatal)
                stringType = "Fatal";

            scriptConsole.output(message, stringType);
        }
    }

//  Labs.Settings
    QtObject
    {
        id: settings

        property int width:  800
        property int height: 600
        property int x
        property int y
    }

    Component.onDestruction:
    {
        settings.x      = x;
        settings.y      = y;
        settings.width  = width;
        settings.height = height;
    }
}
