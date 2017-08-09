import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Popup {

    id: popup

    width: 312
    height: 400

    //todo: how to position at 1/2 horizontally and 2/3 vertically
    x: (parent.width - popup.width) * 0.5
    y: (parent.height - popup.height) * 0.3

    modal: true

    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

    padding: 24

    background: Rectangle {
        color: "white"
        radius: 4
    }

    contentItem: Item {

        Text {

            id: headline

            bottomPadding: 8

            color: "#1D1F21"
            text: "Settings"
            font.pixelSize: 24
            font.letterSpacing: 1.2
            font.weight: Font.Medium
            font.family: "Roboto"
        }

        ColumnLayout {

            anchors.top: headline.bottom
            anchors.topMargin: 24
            anchors.left: parent.left
            anchors.right: parent.right

            spacing: 16

            //global styles
            QtObject {
                id: formStyle

                property font labelFont: Qt.font({
                    pixelSize: 12,
                    capitalization: Font.Uppercase,
                    letterSpacing: 1.2,
                    family: "Roboto"
                });
            }

            RowLayout {

                anchors.left: parent.left
                anchors.right: parent.right

                Text {
                    text: "Log Level"
                }

                ComboBox {

                    anchors.right: parent.right

                    id: logLevel
                    spacing: 5
                    textRole: qsTr("")
                    model: [ "Error", "Warning", "Message", "Debug" ]
                }
            }

            RowLayout {

                anchors.left: parent.left
                anchors.right: parent.right

                Text {
                    text: "Panel Position"
                }

                ComboBox {

                    anchors.right: parent.right

                    id: panelPosition
                    spacing: 5
                    textRole: qsTr("")
                    model: [ "Left", "Right"]
                }
            }

            RowLayout {

                anchors.left: parent.left
                anchors.right: parent.right

                Text {
                    text: "Debug Mode"
                }

                Switch {
                    anchors.right: parent.right
                }
            }
        }
    }

    Text {
        id: acceptButton

        topPadding: 8
        bottomPadding: 8
        rightPadding: 16
        leftPadding: 16

        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.rightMargin: -rightPadding
        anchors.bottomMargin: -bottomPadding

        color: "#C0015D"
        text: "Done"
        font.pixelSize: 14
        font.letterSpacing: 1.4
        font.weight: Font.DemiBold
        font.family: "Roboto"
        font.capitalization: Font.AllUppercase
    }

    MouseArea {
        anchors.fill: acceptButton
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: popup.close()
    }
}
