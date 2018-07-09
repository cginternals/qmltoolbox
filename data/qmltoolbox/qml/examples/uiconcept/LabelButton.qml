import QtQuick 2.0

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0

Button {
    property alias labelFont: label.font
    property alias bgColor: background.color
    property alias textColor: label.color

    anchors.margins: 16

    width: label.implicitWidth + 32

    contentItem: Text {
        id: label

        text: parent.text
        opacity: enabled ? 1.0 : 0.3
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.letterSpacing: 1.1
    }

    background: Rectangle {
        id: background

        width: parent.width
        height: parent.height
        opacity: enabled ? 1 : 0.3
        border.width: 0
        radius: 2
        color: Ui.style.controlColor
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
