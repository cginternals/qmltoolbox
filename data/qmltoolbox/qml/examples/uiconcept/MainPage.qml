
import QtQuick 2.7
import QtQuick.Layouts 1.3

import QtQuick.Controls 1.4 as Controls1
import QtQuick.Controls 2.0
import QmlToolBox.Controls2 1.0 as Controls
import QmlToolBox.PropertyEditor 1.0 as PropertyEditor

import Qt.labs.settings 1.0 as Labs

Page {
    id: page

    Shortcut {
        sequence: "CTRL+F6"
        onActivated: sidePanel.toggle()
    }

    Shortcut {
        sequence: "CTRL+F7"
        onActivated: bottomPanel.toggle()
    }

    Drawer {
        id: drawer
        width: 0.3 * page.width
        height: page.height

        ColumnLayout {
            anchors.fill: parent

            Controls.Button {
                text: qsTr("Back")
                flat: true
                onClicked: drawer.close()
            }

            Controls.ToolButton {
                anchors.left: parent.left
                anchors.right: parent.right

                text: qsTr("Settings")
            }

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
                        text: bottomPanel.isVisible() ? qsTr("Hide Bottom Panel") : qsTr("Show Bottom Panel")
                        onTriggered: bottomPanel.toggle()
                    }
                    Controls.MenuItem {
                        text: sidePanel.isVisible() ? qsTr("Hide Side Panel") : qsTr("Show Side Panel")
                        onTriggered: sidePanel.toggle()
                    }
                }
            }
        }
    }


    Controls1.SplitView {
        anchors.fill: parent
        orientation: Qt.Vertical

        Controls1.SplitView {
            orientation: Qt.Horizontal
            Layout.minimumHeight: 100
            Layout.fillHeight: true

            TestContent {
                Layout.minimumWidth: 100
                Layout.fillWidth: true
            }

            LeftPanel {
                id: sidePanel

                Flickable {
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
        }

        BottomPanel {
            id: bottomPanel

            Controls1.SplitView {
                anchors.fill: parent
                orientation: Qt.Horizontal

                TestContent {
                    id: consolePane
                    width: settings.consoleWidth
                    Layout.minimumWidth: 150
                    Layout.fillWidth: true
                }

                TestContent {
                    id: logPane
                    width: settings.logWidth
                    Layout.minimumWidth: 150
                    Layout.fillWidth: true
                }

                Labs.Settings {
                    id: bottomPanelSettings
                    category: "bottomPanel"
                    property int consoleWidth
                    property int logWidth
                }

                Component.onCompleted: {
                    consolePane.width = bottomPanelSettings.consoleWidth;
                    logPane.width = bottomPanelSettings.logWidth;
                }

                Component.onDestruction: {
                    bottomPanelSettings.consoleWidth = consolePane.width;
                    bottomPanelSettings.logWidth = logPane.width;
                }
            }
        }
    }
}