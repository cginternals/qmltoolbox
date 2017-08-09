import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {

    id: root

    color: "white"

    anchors.fill: parent

    Item {
        anchors.fill: parent
        anchors.topMargin: 56
        anchors.leftMargin: 48
        anchors.rightMargin: 48
        anchors.bottomMargin: 56

        //global styles
        QtObject {
            id: style

            property font headlineFont: Qt.font({
                pixelSize: 24,
                letterSpacing: 1.2,
                family: "Montserrat Light"
            });
        }

        FlatButton {
            id: backButton

            anchors.verticalCenter: headline.verticalCenter

            icon: "icons/ic_arrow_back_black_24px.svg"
            width: hover ? 30 : 20
            x: hover ? -10 : 0
            height: 20

            onClicked: root.visible = false
        }

        Text {

            anchors.left: backButton.right
            anchors.leftMargin: 16

            id: headline
            color: "#1D1F21"
            text: "Select Pipeline"
            font: style.headlineFont
        }

        ProjectGrid {

            id: grid

            anchors.top: headline.bottom
            anchors.topMargin: 40

            anchors.left: parent.left
            anchors.leftMargin: -16

            onItemSelected: {
                console.log('item ' + index + ' clicked');
                root.visible = false;
            }

        }

        TextButton {
            anchors.bottom: parent.bottom
            text: "Load file..."
        }
    }
}
