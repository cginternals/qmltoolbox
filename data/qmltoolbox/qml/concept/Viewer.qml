import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {

    anchors.fill: parent

    Sidebar {
        id: sideBar
    }

    Row {

        anchors.top: parent.top
        anchors.topMargin: 12

        anchors.left: showSidebarBtn.visible ? showSidebarBtn.right : sideBar.right
        anchors.leftMargin: 16

        spacing: 8

        FlatButton {
            icon: "icons/ic_photo_camera_black_24px.svg"
        }

        FlatButton {
            icon: "icons/ic_videocam_black_24px.svg"
        }
    }

    LabelButton {
        id: showConsoleBtn

        height: 24
        width: 120 // todo: contentWidth
        text: "Show Console"
        anchors.leftMargin: 16
        anchors.bottomMargin: 16
        anchors.bottom: parent.bottom
        anchors.left: sideBar.right

        visible: debuggerConsole.state === "hidden"

        onClicked: debuggerConsole.state = ""
    }

    LabelButton {
        id: showSidebarBtn

        height: 24
        width: 120

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 16
        anchors.topMargin: 16

        text: "Show Sidebar"

        onClicked: sideBar.state = ""

        visible: sideBar.state === "hidden"
    }

    Console {

        id: debuggerConsole

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        state: "hidden"
    }
}
