import QtQuick 2.7
import QtQuick.Layouts 1.3

import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QmlToolBox.Controls2 1.0 as Controls

Drawer {
    id: drawer
    width: 0.3 * page.width
    height: page.height

    property alias settingsContent: settings_content.children

    function toggleSettings() {
        stateWrapper.state = (stateWrapper.state == "collapsed") ? "settings" : "collapsed";
    }

    function closeSettings() {
        stateWrapper.state = "collapsed";
    }

    onClosed: { closeSettings(); }

    Item {
        id: stateWrapper

        state: "collapsed"

        states: [
            State { 
                name: "collapsed"
                PropertyChanges {
                    target: drawer
                    width: page.width * 0.3
                }
                PropertyChanges {
                    target: drawer_right_side
                    visible: false
                }
            },

            State {
                name: "settings"
                PropertyChanges { 
                    target: drawer
                    width: page.width
                }
                PropertyChanges {
                    target: drawer_right_side
                    visible: true
                }
            }
        ]

        transitions: [
            Transition {
                from: "collapsed"; to: "settings" 

                SequentialAnimation {
                    NumberAnimation { properties: "width"; easing.type: Easing.InOutQuad }
                    PropertyAction { target: drawer_right_side; properties: "visible" }
                }
            },
            Transition {
                from: "settings"; to: "collapsed"

                SequentialAnimation {
                    PropertyAction { target: drawer_right_side; properties: "visible" }
                    NumberAnimation { properties: "width"; easing.type: Easing.InOutQuad }
                }
            }
        ]
    }

    ColumnLayout {
        id: drawer_left_side

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        width: page.width * 0.3

        Controls.Button {
            text: qsTr("Back")
            flat: true
            onClicked: drawer.close()
        }

        Controls.ToolButton {
            anchors.left: parent.left
            anchors.right: parent.right

            flat: true
            text: qsTr("Settings")
            onClicked: { drawer.toggleSettings(); }
        }

        // ToolSeparator { orientation: Qt.Horizontal }

        Repeater {
            model: 4

            Controls.ToolButton {
                text: "Element " + index
            }
        }

        Item { Layout.fillHeight: true }
    }

    Controls.Pane {
        id: drawer_right_side
        
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: drawer_left_side.right
        anchors.right: parent.right

        visible: true

        Material.elevation: 10

        Item {
            id: settings_content

            anchors.fill: parent
        }
    }
}