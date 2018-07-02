import QtQuick 2.0
import QtQuick.Controls 2.1

TabButton {

    id: control

    padding: 8

    contentItem: Text {
        text: control.text
        font: control.font
        color: control.checked || control.hovered ? "white" : "#BDBDBD"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    indicator: Rectangle {
       z: 2
       height: 2
       width: control.width
       y: control.height - height
       color: "#0EF3F9"
       visible: control.checked
   }

   //size calculation depends on the background so we just hide it
   background.visible: false

   MouseArea {
       anchors.fill: parent
       cursorShape: Qt.PointingHandCursor
       onPressed:  mouse.accepted = false
   }
}
