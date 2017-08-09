import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {

    id: root

    property alias tabIndex: tabBar.currentIndex

    //global styles
    QtObject {
        id: style

        //is used for title and tabbar buttons
        property font mainFont: Qt.font({
            pixelSize: 12,
            capitalization: Font.AllUppercase,
            letterSpacing: 1.2,
            family: "Montserrat Regular",
        });
    }

    height: 40

    Rectangle {
        id: headerBackground
        anchors.fill: parent
        color: "#1D1F21"
    }

    Image {
        id: logo
        width: root.height
        height: root.height
        fillMode: Image.PreserveAspectCrop
        source: "img/logo.svg"
        sourceSize.width: logo.width
        sourceSize.height: logo.height
        smooth: false
    }


    Text {
        id: title

        x: 48
        height: parent.height
        width: 168

        text: "Pipeline title";
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        color: "white"
        elide: Text.ElideRight
        font: style.mainFont
    }

    Button {
        id: loadBtn
        x: 230
        height: 24
        width: 80
        text: "Load file"
        anchors.verticalCenter: parent.verticalCenter

        contentItem: Text {
            text: loadBtn.text
            opacity: enabled ? 1.0 : 0.3
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Roboto Medium"
            font.letterSpacing: 1.1
            font.pixelSize: 11
        }

        background: Rectangle {
            width: parent.width
            height: parent.height
            opacity: enabled ? 1 : 0.3
            border.width: 0
            radius: 2
            color: "#0EF3F9"
        }

        onClicked: welcomeScreen.visible = true
    }

    TabBar {
        background: null
        x: 425
        anchors.bottom: root.bottom
        id: tabBar
        currentIndex: stackLayout.currentIndex

        MyTabButton {
            font: style.mainFont
            text: qsTr("Viewer")
        }

        MyTabButton {
            font: style.mainFont
            text: qsTr("Pipeline")
        }

        MyTabButton {
            font: style.mainFont
            text: qsTr("Debug")
        }
    }

    RowLayout {

        anchors.right: parent.right
        anchors.rightMargin: 8

        anchors.verticalCenter: parent.verticalCenter

        FlatButton {

            icon: "icons/ic_settings_white_24px.svg"
            width: 32
            height: 28

            onClicked: settingsDialog.open()
        }

        FlatButton {
            icon: "icons/icon_maximize.svg"

            width: 32
        }
    }
}
