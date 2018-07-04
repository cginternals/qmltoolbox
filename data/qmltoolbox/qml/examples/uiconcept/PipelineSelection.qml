import QtQuick 2.0

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0

Rectangle
{

    id: root

    color: "white"

    anchors.fill: parent

    Item
    {
        anchors.fill: parent
        anchors.topMargin: 56
        anchors.leftMargin: 48
        anchors.rightMargin: 48
        anchors.bottomMargin: 56
/*
        //global styles
        QtObject
        {
            id: style

            property font headlineFont: Qt.font({
                pixelSize: 24,
                letterSpacing: 1.2,
                family: "Montserrat Light"
            });
        }
*/
        ToolButton
        {
            id: backButton

            anchors.verticalCenter: headline.verticalCenter
            
            background.visible: false

            contentItem: Image
            {
                source: "icons/ic_arrow_back_black_24px.svg"
            }

            width: hovered ? 48 : 32
            x: hovered ? -16 : 0
            height: 32

            onClicked: root.visible = false
        }

        Label
        {

            anchors.left: backButton.right
            anchors.leftMargin: 16

            id: headline
            color: "#1D1F21"
            text: "Select Pipeline"
            //font: style.headlineFont
            font.pointSize: Ui.style.fontSizeLarge
        }

        PipelinePage
        {
            anchors.top: headline.bottom
            anchors.topMargin: 40

            anchors.left: parent.left
            anchors.leftMargin: -16
        }
/*
        ProjectGrid
        {

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
*/
        ToolButton
        {
            anchors.bottom: parent.bottom
            text: "Load file..."
        }
    }
}
