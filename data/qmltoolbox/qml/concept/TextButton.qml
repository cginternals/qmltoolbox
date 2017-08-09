import QtQuick 2.0

Text {

    signal clicked

    anchors.bottom: parent.bottom
    color: mouseArea.containsMouse ? "#C0015D" : "#A3AEBB"
    text: "<label>"

    font.pixelSize: 24
    font.letterSpacing: 1.2
    font.family: "Montserrat Light"

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
