
import QtQuick 2.7
import QtQuick.Layouts 1.3

import QtQuick.Controls 1.4 as Controls1
import QtQuick.Controls 2.0
import QmlToolBox.Controls2 1.0 as Controls

Controls.ApplicationWindow
{
    id: window
    width: 800
    height: 600
    visible: true

    Drawer {
        id: drawer
        width: 0.3 * window.width
        height: window.height

        ColumnLayout {
            anchors.fill: parent


            Controls.Button {
                text: "Back"
                flat: true
                onClicked: drawer.close()
            }

            Controls.ToolButton {
                anchors.left: parent.left
                anchors.right: parent.right

                text: "Settings"
                flat: true
            }

            Item { Layout.fillHeight: true }
        }
    }

    header: Controls.ToolBar {
        id: toolBar

        RowLayout {
            anchors.fill: parent

            Controls.ToolButton {
                text: "Menu"
                onClicked: drawer.open()
            }

            Item { Layout.fillWidth: true }

            Controls.ToolButton {
                text: "Pipeline"
                onClicked: pipelineMenu.open()

                Menu {
                    id: pipelineMenu
                    y: toolBar.height

                    MenuItem { text: "Details" }
                    MenuItem { text: "Edit" }
                }
            }
            Controls.ToolButton {
                text: "Tools"
                onClicked: toolsMenu.open()

                Menu {
                    id: toolsMenu
                    y: toolBar.height

                    MenuItem { text: "Record" }
                    MenuItem { text: "Take Screenshot" }
                }
            }
            Controls.ToolButton {
                text: "View"
                onClicked: viewMenu.open()

                Menu {
                    id: viewMenu
                    y: toolBar.height

                    MenuItem { 
                        text: "Toggle Bottom Area" 
                        onTriggered: bottomPanel.toggle()
                    }
                    MenuItem { 
                        text: "Toggle Side Area" 
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
            Layout.fillHeight: true

            TestContent {
                Layout.fillWidth: true
            }

            LeftPanel {
                id: sidePanel

                TestContent {}
            }
        }

        BottomPanel {
            id: bottomPanel

            Controls1.SplitView {
                anchors.fill: parent
                orientation: Qt.Horizontal

                TestContent {
                    Layout.minimumWidth: 150
                    Layout.fillWidth: true
                }

                TestContent {
                    Layout.minimumWidth: 150
                    Layout.fillWidth: true
                }
            }
        }
    }
}