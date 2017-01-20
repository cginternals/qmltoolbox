
import QtQuick 2.4
import QtQuick.Layouts 1.1

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0
import QmlToolbox.Ui 1.0

Item {
    id: drawer

    default property alias contents: layout.children

    anchors.top: parent.top
    anchors.bottom: parent.bottom
    implicitWidth: 300
    state: "visible"

    Rectangle {
        anchors.fill: parent
        color: Ui.style.frameColor
    }

    Control {
        id: drawerButton

        parent: drawer.parent
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 10
        implicitHeight: 40
        implicitWidth: label.implicitWidth

        onClicked: { 
            drawer.state = (drawer.state == "visible") ? "hidden" : "visible";
        }

        Label {
            id: label

            anchors.verticalCenter: parent.verticalCenter
            text: (drawer.state == "visible") ? "Back" : "Open"
            color: drawerButton.selectStyle(Ui.style.controlTextColorDisabled, Ui.style.controlTextColorPressed, Ui.style.controlTextColorHover, Ui.style.controlTextColorSelected, Ui.style.controlTextColor)
        }
    }

    ColumnLayout {
        id: layout

        anchors.top: parent.top
        anchors.topMargin: 40
        width: parent.width
    }

    states: [
        State {
            name: "visible"

            AnchorChanges { 
                target: drawer
                anchors.left: parent.left
                anchors.right: undefined
            }
            PropertyChanges { target: drawer; visible: true }
        },
        State {
            name: "hidden"

            AnchorChanges { 
                target: drawer
                anchors.left: undefined
                anchors.right: parent.left
            }
            PropertyChanges { target: drawer; visible: false }
        }
    ]

    transitions: [
        Transition {
            from: "visible"
            to: "hidden"

            SequentialAnimation {
                AnchorAnimation { duration: 250; easing.type: Easing.InOutQuad }
                NumberAnimation { property: "visible"; duration: 0 }
            }
        },
        Transition {
            from: "hidden"
            to: "visible"

            SequentialAnimation {
                NumberAnimation { property: "visible"; duration: 0 }
                AnchorAnimation { duration: 250; easing.type: Easing.InOutQuad }
            }
        }
    ]
}