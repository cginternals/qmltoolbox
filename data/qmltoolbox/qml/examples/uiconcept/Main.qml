
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
        sequence: "ESC"
        onActivated: mainMenu.open()
    }

    Shortcut
    {
        sequence: "CTRL+F6"
        onActivated: sidePanel.toggleVisible()
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

    header: ToolBar
    {
        id: toolBar

        Rectangle {
            id: headerBackground
            anchors.fill: parent
            color: "#1D1F21"
        }

        RowLayout
        {
            anchors.fill: parent

            spacing: 8

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
                color: "white"
            }

            Button
            {
                id: loadBtn
                height: 24
                width: 80
                text: "Load file"
                anchors.verticalCenter: parent.verticalCenter

                contentItem: Text {
                    text: loadBtn.text
                    opacity: enabled ? 1.0 : 0.3
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Roboto Medium"
                    font.letterSpacing: 1.1
                    font.pixelSize: 11
                }

                background: Rectangle {
                    width: parent.width
                    height: parent.height
                    opacity: enabled ? 1 : 0.3
                    border.width: 0
                    radius: 2
                    color: "#0EF3F9"
                }

                // TODO
                onClicked: pipelineSelection.visible = true
            }

            Item
            {
                Layout.fillWidth: true
            }

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
                Layout.fillWidth: true
            }

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

    MainMenu
    {
        id: mainMenu

        settingsObj: settings
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
            currentIndex: tabBar.currentIndex

            // Main view
            Item
            {
                id: mainView

                anchors.fill: parent

                Rectangle
                {
                    anchors.left:   sidePanel.position == 'left' ? sidePanel.right : parent.left
                    anchors.right:  sidePanel.position == 'left' ? parent.right : sidePanel.left
                    anchors.top:    parent.top
                    anchors.bottom: parent.bottom

                    color: Ui.style.backgroundColor
                }

                Row
                {
                    id: toolButtonRow

                    anchors.top: parent.top
                    anchors.topMargin: 12
                    anchors.leftMargin: 16
                    anchors.rightMargin: 16

                    spacing: 8

                    states:
                    [
                        State
                        {
                            name: "anchoredLeftPanel"
                            when: sidePanel.isVisible() && sidePanel.position == 'left'

                            AnchorChanges
                            {
                                target: toolButtonRow
                                anchors.right: undefined
                                anchors.left: sidePanel.right
                            }
                        },
                        State
                        {
                            name: "anchoredLeftViewer"
                            when: !sidePanel.isVisible() && sidePanel.position == 'left'

                            AnchorChanges
                            {
                                target: toolButtonRow
                                anchors.right: undefined
                                anchors.left: mainView.left
                            }
                        },
                        State
                        {
                            name: "anchoredRightPanel"
                            when: sidePanel.isVisible() && sidePanel.position == 'right'

                            AnchorChanges
                            {
                                target: toolButtonRow
                                anchors.left: undefined
                                anchors.right: sidePanel.left
                            }
                        },
                        State
                        {
                            name: "anchoredrightViewer"
                            when: !sidePanel.isVisible() && sidePanel.position == 'right'

                            AnchorChanges
                            {
                                target: toolButtonRow
                                anchors.left: undefined
                                anchors.right: mainView.right
                            }
                        }
                    ]

                    ToolButton
                    {
                        text: "Show Side Panel"
                        visible: !sidePanel.isVisible() && sidePanel.position == 'left'

                        onClicked: sidePanel.setVisible(true)
                    }

                    ToolButton
                    {
                        contentItem: Image
                        {
                            source: "icons/ic_photo_camera_black_24px.svg"

                            width: 24
                            height: 24
                        }

                        background.visible: false
                    }

                    ToolButton
                    {
                        contentItem: Image
                        {
                            source: "icons/ic_videocam_black_24px.svg"

                            width: 24
                            height: 24
                        }

                        background.visible: false
                    }

                    ToolButton
                    {
                        text: "Show Side Panel"
                        visible: !sidePanel.isVisible() && sidePanel.position == 'right'

                        onClicked: sidePanel.setVisible(true)
                    }
                }

                ToolButton
                {
                    text: "Show Console"
                    anchors.bottom: parent.bottom
                    anchors.left: sidePanel.position == 'left' ? sidePanel.right : parent.left
                    anchors.leftMargin: 8
                    anchors.bottomMargin: 8

                    visible: !bottomPanel.isVisible()

                    onClicked: bottomPanel.setVisible(true)
                }

                // Side Panel
                Panel
                {
                    id: sidePanel

                    position:    settings.panelPosition
                    minimumSize: 240

                    RowLayout
                    {
                        id: sideCaption

                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top

                        anchors.leftMargin: 8
                        anchors.rightMargin: 8

                        Label
                        {
                            text: "Properties"
                        }

                        Item
                        {
                            Layout.fillWidth: true
                        }

                        ToolButton
                        {
                            contentItem: Image
                            {
                                source: "icons/icon_close_sidebar.svg"
                            }

                            background.visible: hovered

                            onClicked: sidePanel.setVisible(false)
                        }
                    }

                    ScrollArea
                    {
                        id: scrollArea

                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: sideCaption.bottom
                        anchors.bottom: parent.bottom

                        contentHeight: propertyEditor.height

                        flickableDirection: Flickable.VerticalFlick
                        boundsBehavior:     Flickable.StopAtBounds

                        PropertyEditor
                        {
                            id: propertyEditor

                            width: scrollArea.width

                            properties: demoProperties
                            path:       'root'

                            Component.onCompleted:
                            {
                                propertyEditor.update()
                            }
                        }
                    }
                }
            }

            // Pipeline view
            PipelineView
            {
                id: pipelineView

                anchors.fill: parent

                properties: demoProperties

                ToolButton
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
                    tabBar.currentIndex = 0;
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
    Panel
    {
        id: bottomPanel

        position:    'bottom'
        minimumSize: 150
        visible:     false

        ScriptConsole
        {
            id: scriptConsole

            anchors.fill: parent

            keywords: ["console", "Math", "Date", "if", "for", "while", "function", "exit"]

            onSubmitted:
            {
                scriptConsole.output("> " + command + "\n");
                var res = eval(command);

                if (res !== undefined)
                {
                    console.log(scriptConsole.prettyPrint(res));
                }
            }
        }

        ToolButton
        {
            anchors.right: parent.right
            anchors.top: parent.top

            contentItem: Image
            {
                source: "icons/icon_close_sidebar.svg"
            }

            background.visible: hovered

            onClicked: bottomPanel.setVisible(false)
        }
    }

    // Output capturing
    MessageForwarder
    {
        id: message_forwarder

        onMessageReceived:
        {
            // Put message on console log
            scriptConsole.output(message, type);
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

    Component.onCompleted:
    {
        settings.load();
        window.visible = true;
    }

    Component.onDestruction:
    {
        settings.x      = x;
        settings.y      = y;
        settings.width  = width;
        settings.height = height;
    }
}
