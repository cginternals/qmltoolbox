import QtQuick 2.0
import QtQuick.Controls 2.1

Button {

    height: 25
    width: 120 // todo: contentWidth

    anchors.margins: 16

    contentItem: Text {
        text: parent.text
        opacity: enabled ? 1.0 : 0.3
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.letterSpacing: 1.1
    }

    background: Rectangle {
        width: parent.width
        height: parent.height
        opacity: enabled ? 1 : 0.3
        border.width: 0
        radius: 2
        color: "#BDBDBD"
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
