
import QtQuick 2.7
import QtQuick.Layouts 1.3

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

                    MenuItem { text: "Show Console" }
                    MenuItem { text: "Show Log" }
                }
            }
        }
    }

    Controls.Pane {
        ColumnLayout {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            Controls.Label {
                text: "Settings"
            }
            Controls.Slider {
                value: 0.5
            }
            Controls.Button {
                text: "Save"
            }
        }
    }

    ColumnLayout {
        id: bottomPane

        height: 200
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Item {
            height: 1
            anchors.left: parent.left
            anchors.right: parent.right

            Rectangle {
                anchors.fill: parent

                color: "#1D1F21"
            }

            MouseArea {
                id: mouseArea

                anchors.fill: parent
                cursorShape: Qt.SplitVCursor
                acceptedButtons: Qt.LeftButton

                property double oldHeight

                onPressed: {
                    oldHeight = bottomPane.height
                }

                onMouseYChanged: { 
                    bottomPane.height = oldHeight - mouseY
                }
            }
        }

        Controls.Pane {
            anchors.left: parent.left
            anchors.right: parent.right
            Layout.fillHeight: true

            Flickable {
                anchors.fill: parent

                flickableDirection: Flickable.VerticalFlick

                TextArea.flickable: TextArea {
                    id: logTextArea
                    text: "TextArea\n...\n...\n...\n...\n...\n...\n"
                    wrapMode: TextArea.Wrap
                }
            }
        }
    }



    // ColumnLayout {
    //     anchors.fill: parent

    //     Controls.Pane {
    //         Layout.fillHeight: true

    //         ColumnLayout {
    //             anchors.top: parent.top
    //             anchors.left: parent.left
    //             anchors.right: parent.right

    //             Controls.Label {
    //                 text: "Settings"
    //             }
    //             Controls.Slider {
    //                 value: 0.5
    //             }
    //             Controls.Button {
    //                 text: "Save"
    //             }
    //         }
    //     }

    //     Controls.Pane {
    //         height: 200
    //         Layout.fillWidth: true

    //         // TextArea {
    //         //     anchors.fill: parent
    //         // }
    //         Flickable {
    //             id: flickable
    //             anchors.fill: parent
    //             contentHeight: logTextArea.height
    //             contentWidth: logTextArea.width

    //             TextArea.flickable: TextArea {
    //                 id: logTextArea
    //                 text: "TextArea\n...\n...\n...\n...\n...\n...\n"
    //                 wrapMode: TextArea.Wrap
    //             }

    //             ScrollBar.vertical: ScrollBar { }
    //         }
    //     }
    // }
}