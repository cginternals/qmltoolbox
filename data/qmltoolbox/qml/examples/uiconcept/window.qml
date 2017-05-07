
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
        onActivated: rightPanel.toggleVisible()
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

    function togglePreviewMode() 
    {
        stateWrapper.state = (stateWrapper.state == "normal") ? "preview" : "normal";
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

                StateChangeScript { script: rightPanel.setVisible(false) }
                StateChangeScript { script: bottomPanel.setVisible(false) }

                PropertyChanges 
                {
                    target: window
                    header: null
                }

                PropertyChanges 
                {
                    target: drawer
                    visible: false
                }
            },
            State 
            {
                name: "normal"

                StateChangeScript { script: rightPanel.setVisible(true) }
                StateChangeScript { script: bottomPanel.setVisible(true) }
            }
        ]
    }

    function toggleFullScreenMode()
    {
        fsStateWrapper.state = (fsStateWrapper.state == "windowedMode") ? "fullScreenMode" : "windowedMode";
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

    Components.Drawer 
    {
        id: drawer

        settingsContent: ColumnLayout
        {
            anchors.fill: parent

            TestContent { }

            Item { Layout.fillHeight: true }
        }
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
                onClicked: drawer.open()
            }

            Item { Layout.fillWidth: true }

            Controls.ToolButton 
            {
                text: qsTr("Pipeline")
                onClicked: pipelineMenu.open()

                Controls.Menu {
                    id: pipelineMenu
                    y: toolBar.height

                    Controls.MenuItem { text: qsTr("Details") }
                    Controls.MenuItem { text: qsTr("Edit") }
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

                    Controls.MenuItem { text: qsTr("Record") }
                    Controls.MenuItem { text: qsTr("Take Screenshot") }
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
                        text: bottomPanel.isVisible() ? qsTr("Hide Console") : qsTr("Show Console")
                        onTriggered: bottomPanel.toggleVisible()
                    }

                    Controls.MenuItem 
                    {
                        text: rightPanel.isVisible() ? qsTr("Hide Side Panel") : qsTr("Show Side Panel")
                        onTriggered: rightPanel.toggleVisible()
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

    Item
    {
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.top:    parent.top
        anchors.bottom: bottomPanel.top

        TestContent
        {
            anchors.left:   parent.left
            anchors.right:  rightPanel.left
            anchors.top:    parent.top
            anchors.bottom: parent.bottom
        }

        Controls.Panel
        {
            id: rightPanel

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

                    pipelineInterface: Qt.createComponent("PipelineDummy.qml").createObject(propertyEditor);
                    path: 'root'

                    Component.onCompleted: propertyEditor.update()
                }
            }
        }
    }

    Controls.Panel
    {
        id: bottomPanel

        position:    'bottom'
        minimumSize: 150

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

        property int width: 800
        property int height: 600
        property int x
        property int y
    }

    Component.onDestruction: 
    {
        settings.x = x;
        settings.y = y;
        settings.width = width;
        settings.height = height;
    }
}
