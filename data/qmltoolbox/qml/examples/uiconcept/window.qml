
import QtQuick 2.7
import QtQuick.Layouts 1.3

import QtQuick.Controls 1.4 as Controls1
import QtQuick.Controls 2.0
import QmlToolBox.Controls2 1.0 as Controls
import QmlToolBox.PropertyEditor 1.0 as PropertyEditor

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

                Controls.Menu {
                    id: pipelineMenu
                    y: toolBar.height

                    Controls.MenuItem { text: "Details" }
                    Controls.MenuItem { text: "Edit" }
                }
            }
            Controls.ToolButton {
                text: "Tools"
                onClicked: toolsMenu.open()

                Controls.Menu {
                    id: toolsMenu
                    y: toolBar.height

                    Controls.MenuItem { text: "Record" }
                    Controls.MenuItem { text: "Take Screenshot" }
                }
            }
            Controls.ToolButton {
                text: "View"
                onClicked: viewMenu.open()

                Controls.Menu {
                    id: viewMenu
                    y: toolBar.height

                    Controls.MenuItem { 
                        text: "Toggle Bottom Area" 
                        onTriggered: bottomPanel.toggle()
                    }
                    Controls.MenuItem { 
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