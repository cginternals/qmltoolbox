import QtQuick 2.0
import QtQuick.Controls 2.1

import QmlToolbox.Base 1.0

TabButton {

    id: control

    padding: 8

    contentItem: Text {
        text: control.text
        font: control.font
        color: control.checked || control.hovered ? Ui.style.itemColor : Ui.style.itemColorHighlighted
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    indicator: Rectangle {
       z: 2
       height: 2
       width: control.width
       y: control.height - height
       color: Ui.style.backgroundSignalColor
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
