
import QtQuick 2.7
import QtQuick.Layouts 1.3

import QtQuick.Controls 2.0
import QmlToolBox.Controls2 1.0 as Controls

Controls.Pane {
    id: root

    function addLine(text, type) {
        model.append({ text: text, type: type});
        view.scrollToBottom();
    }

    property var model: ConsoleModel {}

    leftPadding: 0
    rightPadding: 0
    
    background: Rectangle {
        color: "#1D1F21";
    }

    ListView {
        id: view

        function colorForType(type) {
            if (type == "Warning")
                return "#81A2BE";

            if (type == "Error")
                return "#DE935F";

            if (type == "Info")
                return "#808080";

            return "#C5C8C6";
        }

        anchors.fill: parent

        clip: true
        boundsBehavior: Flickable.StopAtBounds

        ScrollBar.vertical: ScrollBar {
            Component.onCompleted: {
                contentItem.color = "#3F4042"
            }
        }

        model: root.model

        delegate: Controls.Label {
            anchors.left: parent.left
            anchors.right: parent.right

            leftPadding: 12
            rightPadding: 12

            text: model.text
            color: view.colorForType(model.type)
            font.family: "Menlo"    

        }

        function scrollToBottom() {
            contentY = contentHeight - height;
        }
    }
}