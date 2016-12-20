
import QtQuick 2.7
import QtQuick.Layouts 1.3

import QtQuick.Controls 1.4 as Controls1
import QtQuick.Controls 2.0
import QmlToolBox.Controls 1.0 as Controls
import QmlToolBox.Components 1.0 as Components
import QmlToolBox.PropertyEditor 1.0 as PropertyEditor

import Qt.labs.settings 1.0 as Labs

import com.cginternals.qmltoolbox 1.0

Page {
    id: page

    Shortcut {
        sequence: "CTRL+F6"
        onActivated: leftPanelView.togglePanel()
    }

    Shortcut {
        sequence: "CTRL+F7"
        onActivated: bottomPanelView.togglePanel()
    }

    Shortcut {
        sequence: "CTRL+F11"
        onActivated: togglePreviewMode();
    }

    function togglePreviewMode() {
        stateWrapper.state = (stateWrapper.state == "") ? "preview" : "";
    }

    Item {
        id: stateWrapper

        state: ""

        states: [
            State {
                name: "preview"
                PropertyChanges {
                    target: sidePanel
                    visible: false
                }
                PropertyChanges {
                    target: bottomPanel
                    visible: false
                }
                PropertyChanges {
                    target: page
                    header: null
                }
                PropertyChanges {
                    target: drawer
                    visible: false
                }
            }
        ]
    }

    CustomDrawer {
        id: drawer

        settingsContent: ColumnLayout {
            anchors.fill: parent

            TestContent {}

            Item { Layout.fillHeight: true }
        }
    }

    header: Controls.ToolBar {
        id: toolBar

        RowLayout {
            anchors.fill: parent

            Controls.ToolButton {
                text: qsTr("Menu")
                onClicked: drawer.open()
            }

            Item { Layout.fillWidth: true }

            Controls.ToolButton {
                text: qsTr("Pipeline")
                onClicked: pipelineMenu.open()

                Controls.Menu {
                    id: pipelineMenu
                    y: toolBar.height

                    Controls.MenuItem { text: qsTr("Details") }

                    Controls.MenuItem { 
                        text: qsTr("Edit")
                        onTriggered: page.StackView.view.push(Qt.createComponent("PipelinePage.qml"))
                    }
                }
            }
            Controls.ToolButton {
                text: qsTr("Tools")
                onClicked: toolsMenu.open()

                Controls.Menu {
                    id: toolsMenu
                    y: toolBar.height

                    Controls.MenuItem { text: qsTr("Record") }
                    Controls.MenuItem { text: qsTr("Take Screenshot") }
                }
            }
            Controls.ToolButton {
                text: qsTr("View")
                onClicked: viewMenu.open()

                Controls.Menu {
                    id: viewMenu
                    y: toolBar.height

                    Controls.MenuItem { 
                        text: bottomPanelView.isPanelVisible() ? qsTr("Hide Console") : qsTr("Show Console")
                        onTriggered: bottomPanelView.togglePanel()
                    }
                    Controls.MenuItem {
                        text: leftPanelView.isPanelVisible() ? qsTr("Hide Side Panel") : qsTr("Show Side Panel")
                        onTriggered: leftPanelView.togglePanel()
                    }
                }
            }
        }
    }

    Components.BottomPanelView {
        id: bottomPanelView

        anchors.fill: parent

        Components.LeftPanelView {
            id: leftPanelView

            anchors.fill: parent

            TestContent { }

            panel.minimumWidth: 240

            panelContent: Flickable {
                anchors.fill: parent

                flickableDirection: Flickable.VerticalFlick
                boundsBehavior: Flickable.StopAtBounds

                contentHeight: propertyEditor.height
            
                PropertyEditor.PropertyEditor {
                    id: propertyEditor

                    pipelineInterface: Qt.createComponent("PipelineDummy.qml").createObject(propertyEditor);
                    path: 'root'

                    Component.onCompleted: propertyEditor.update();
                }

                ScrollBar.vertical: ScrollBar {}
            }
        }

        panel.minimumHeight: 150

        panelContent: ColumnLayout {
            anchors.fill: parent

            MessageForwarder {
                id: message_forwarder

                onMessageReceived: {
                    var stringType;
                    if (type == MessageForwarder.Debug)
                        stringType = "Debug";
                    else if (type == MessageForwarder.Warning)
                        stringType = "Warning"; 
                    else if (type == MessageForwarder.Critical)
                        stringType = "Critical";
                    else if (type == MessageForwarder.Fatal)
                        stringType = "Fatal";

                    console_view.append(message, stringType);
                }
            }

            Components.Console {
                id: console_view

                anchors.left: parent.left
                anchors.right: parent.right

                rightPadding: 0

                Layout.minimumHeight: 50
                Layout.fillHeight: true
            }

            Components.CommandLine {
                id: command_line

                anchors.left: parent.left
                anchors.right: parent.right

                topPadding: 0
                bottomPadding: 0

                autocompleteModel: AutocompleteModel { }

                onSubmitted: { 
                    console_view.append("> " + command + "\n", "Command");
                    var res = eval(command);

                    if (res != undefined)
                        console.log(res);
                }
            }
        }
    }
}