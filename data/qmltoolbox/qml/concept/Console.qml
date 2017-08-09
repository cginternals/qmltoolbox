import QtQuick 2.0

//TODO: replace this placeholder with the console component
//      make sure to keep anchors, states and transitions
Item {

    id: root

    height: parent.width * (img.sourceSize.height / img.sourceSize.width)

    states: State {
       name: "hidden"
       AnchorChanges {
           target: root
           anchors.bottom: undefined
           anchors.top: parent.bottom
       }
    }

    transitions: Transition {
        AnchorAnimation {
            duration: 450
            easing.type: Easing.InOutQuad
        }
    }

    Image {

        id: img
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source: "console.png"
    }

    MouseArea {
        width: 25
        height: 25
        id: closeConsole
        anchors.right: parent.right
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: root.state = "hidden"
    }
}
