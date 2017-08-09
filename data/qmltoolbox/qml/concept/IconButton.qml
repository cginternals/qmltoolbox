import QtQuick 2.0
import QtQuick.Controls 2.1

Button {


    id: root

    property alias icon: image.source

    implicitWidth: 48
    implicitHeight: 32

    padding: 4

    opacity: enabled ? 1 : 0.3

    background: Rectangle {
        width: parent.width
        height: parent.height
        border.width: 1
        border.color: "#BDBDBD"
        radius: 2
        color: "#F1F1F1"
    }

    contentItem: Image {

        width: 24
        height: 24

        id: image
        source: "icons/ic_more_horiz_black_24px.svg"
        fillMode: Image.PreserveAspectFit
        smooth: false
        sourceSize.width: width
        sourceSize.height: height
        opacity: mouseArea.containsMouse ? 0.75 : 0.5
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
    }

    Component.onCompleted: {
        mouseArea.clicked.connect(clicked)
    }
}
