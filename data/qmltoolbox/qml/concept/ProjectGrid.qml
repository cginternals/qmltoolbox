import QtQuick 2.6

Flow {
    id: root

    signal itemSelected(int index)

    anchors.left: parent.left
    anchors.right: parent.right

    Repeater {
        model: GridModel {}

        delegate: Item {

            id: item
            width: 320
            height: 112

            Row {

                spacing: 16

                leftPadding: 16
                rightPadding: 16

                anchors.verticalCenter: parent.verticalCenter

                Image {

                    horizontalAlignment: Image.AlignHCenter
                    width: 64
                    height: 64
                    fillMode: Image.PreserveAspectFit
                    source: thumb
                }

                Column {

                    topPadding: 8
                    spacing: 8

                    Text {
                        width: 210

                        text: name

                        elide: Text.ElideRight
                        color: mouse.containsMouse ? "#C0015D" : "#1D1F21"
                        lineHeight: 1.1
                        font.pixelSize: 16
                        font.letterSpacing: 1.3
                        font.family: "Montserrat"
                    }

                    Text {
                        width: 210

                        text: subtitle
                        maximumLineCount: 2
                        elide: Text.ElideRight
                        color: "#A3AEBB"
                        font.pixelSize: 14
                        font.letterSpacing: -0.8
                        font.family: "Inconsolata"
                        wrapMode: Text.WordWrap
                    }
                }
            }

            Rectangle {
                border.color: "#E1E1E1"
                border.width: 1
                anchors.fill: parent
                color: "white"
                radius: 4
                z: -1
                visible: mouse.containsMouse
            }

            //Mouse area to react on mouse events
            MouseArea {
                anchors.fill: parent
                id: mouse
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onPressed: root.itemSelected(index)
            }
        }
    }
}
