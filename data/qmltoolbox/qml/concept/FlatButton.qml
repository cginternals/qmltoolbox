import QtQuick 2.0

Item {

    signal clicked

    readonly property alias hover: mouseArea.containsMouse

    property alias icon: image.source

    width: 32
    height: 32

    Image {

        id: image

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        width: 24
        height: 24

        fillMode: Image.PreserveAspectFit
        opacity: hover ? 1.0 : 0.65

        smooth: false

        sourceSize.width: width
        sourceSize.height: height
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
