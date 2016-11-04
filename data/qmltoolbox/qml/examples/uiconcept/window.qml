
import QtQuick 2.7
import QtQuick.Layouts 1.3

import QtQuick.Controls 1.4 as Controls1
import QtQuick.Controls 2.0
import QmlToolBox.Controls2 1.0 as Controls

ApplicationWindow
{
    id: window
    width: 800
    height: 600
    visible: true

    Drawer {
        id: drawer
        width: 0.3 * window.width
        height: window.height

        Controls.Button {
            text: "Back"
            flat: true
            onClicked: drawer.close()
        }
    }

    header: ToolBar {
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
                }
            }
        }
    }


    Controls1.SplitView {
        anchors.fill: parent
        orientation: Qt.Vertical

        TestContent {
            Layout.fillHeight: true
        }

        BottomPanel {
            id: bottomPanel

            Controls1.SplitView {
                anchors.fill: parent
                orientation: Qt.Horizontal

                TestContent {
                    Layout.minimumWidth: 150
                }

                TestContent {
                    Layout.minimumWidth: 150
                }
            }
        }
    }
}