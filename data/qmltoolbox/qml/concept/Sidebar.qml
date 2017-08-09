import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {

    id: control

    width: 312

    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.left: parent.left

    states: State {
       name: "hidden"
       AnchorChanges {
           target: control
           anchors.right: parent.left
           anchors.left: undefined
       }
    }

    transitions: Transition {
        AnchorAnimation {
            duration: 450
            easing.type: Easing.InOutQuad
        }
    }

    Rectangle {
        id: background
        color: "white"

        anchors.fill: parent

        /*
        DropShadow {

            source: parent

            color: "black"
            radius: 5
            cached: true
            horizontalOffset: 5
        }
        */

        RectangularGlow {
            anchors.fill: parent
            cached: true
            color: "#d8d8d8"
            glowRadius: 16
            z: -1
        }
    }

    Item {
        id: sidebarHead

        width: parent.width
        height: 48

        Text {

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 16

            text: "Properties"
            color: "#c4ccd5"
            verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.AllUppercase
            font.letterSpacing: 1.2
            font.family: "Montserrat"
            font.pixelSize: 12
        }

        FlatButton {
            id: closeBtn

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 8

            icon: "icons/icon_close_sidebar.svg"

            onClicked: control.state = "hidden"
        }
    }

    ColumnLayout {
        anchors.top: sidebarHead.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        anchors.topMargin: -8

        spacing: 8

        PropertyLabel {
            text: "fontFilename"
        }

        RowLayout {

            anchors.left: parent.left
            anchors.right: parent.right

            TextField {

                implicitHeight: 32

                anchors.left: parent.left
                anchors.right: btn.left
                anchors.rightMargin: 8
                text: "C:\\Fonts\\Roboto.ttf"

                background: Rectangle {
                    width: parent.width
                    height: parent.height
                    opacity: enabled ? 1 : 0.3
                    border.width: 1
                    border.color: "#BDBDBD"
                    radius: 2
                    color: "white"
                }
            }

            IconButton {
                id: btn
                anchors.right: parent.right

                implicitWidth: 48
                implicitHeight: 32

                icon: "icons/ic_more_horiz_black_24px.svg"

                onClicked: console.log('TODO: open file browser')
            }
        }

        PropertyLabel {
            text: "text"
        }

        TextField {

            implicitHeight: 32

            anchors.left: parent.left
            anchors.right: parent.right

            text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr"

            placeholderText: qsTr("Enter your text")

            background: Rectangle {
                width: parent.width
                height: parent.height
                opacity: enabled ? 1 : 0.3
                border.width: 1
                border.color: "#BDBDBD"
                radius: 2
                color: "white"
            }
        }

        PropertyLabel {
            text: "fontSize"
        }

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right

            Slider {
                id: fontSize
                anchors.left: parent.left
                anchors.right: txtField.left
                anchors.rightMargin: 24

                padding: 0

                from: 1
                to: 99
                value: 24
                snapMode: Slider.SnapAlways
                stepSize: 1

                background: Rectangle {

                   anchors.verticalCenter: parent.verticalCenter
                   width: parent.availableWidth
                   height: 2
                   radius: 2
                   color: "#D2D2D2"
               }

                Component.onCompleted: {
                    handle.implicitWidth = 16
                    handle.implicitHeight = 16
                    handle.border.width = 1
                }
            }

            TextField {
                implicitWidth: 32
                implicitHeight: 32
                id: txtField
                anchors.right: parent.right
                text: Math.ceil(fontSize.valueAt(fontSize.position))

                //TODO: add bidirectional data binding (allow text field editing)
                readOnly: true

                background: Rectangle {
                    width: parent.width
                    height: parent.height
                    opacity: enabled ? 1 : 0.3
                    border.width: 1
                    border.color: "#BDBDBD"
                    radius: 2
                    color: "white"
                }
            }
        }

        RowLayout {

            anchors.left: parent.left
            anchors.right: parent.right

            PropertyLabel {
                lineHeight: 16
                text: "wordWrap"
            }

            Switch {
                anchors.right: parent.right
                anchors.topMargin: 8

                implicitHeight: 32
            }
        }

        /*
        CheckBox {

            implicitWidth: 32
            implicitHeight: 32

            anchors.right: parent.right

            Component.onCompleted: {
                indicator.implicitWidth = width;
                indicator.implicitHeight = height;
                indicator.radius = 2;
                indicator.border.color = "#BDBDBD";
            }
        }
        */

        PropertyLabel {
            text: "alignment"
        }

        ComboBox {

            id: box

            implicitHeight: 32

            background: Rectangle {
                width: parent.width
                height: parent.height
                opacity: enabled ? 1 : 0.3
                border.width: 1
                border.color: "#BDBDBD"
                radius: 2
                color: "white"
            }

            indicator: Item {
                anchors.right: parent.right
                width: 48
                height: parent.height

                //vertical separator
                Rectangle {
                    anchors.right: parent.left
                    width: 1
                    height: parent.height
                    border.width: 0
                    color: "#BDBDBD"
                }

                Image {

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    width: 16
                    height: 16

                    source: "icons/ic_keyboard_arrow_down_black_24px.svg"
                    sourceSize.width: width
                    sourceSize.height: height
                }
            }

            anchors.left: parent.left
            anchors.right: parent.right

            spacing: 8
            textRole: qsTr("")
            model: [ "Left", "Right", "Center" ]
        }


        PropertyLabel {
            text: "textureImage"
        }

        RowLayout {

            anchors.left: parent.left
            anchors.right: parent.right

            TextField {

                implicitHeight: 32

                anchors.left: parent.left
                anchors.right: thumb.left
                anchors.rightMargin: 8

                text: "C:\\textures\\placeholder.png"

                background: Rectangle {
                    width: parent.width
                    height: parent.height
                    opacity: enabled ? 1 : 0.3
                    border.width: 1
                    border.color: "#BDBDBD"
                    radius: 2
                    color: "white"
                }
            }

            Image {

                id: thumb

                anchors.right: parent.right

                width: 80
                height: 32

                sourceSize.width: width
                sourceSize.height: height

                fillMode: Image.PreserveAspectCrop

                source: "img/texture_placeholder.png"
            }
        }

        RowLayout {

            anchors.left: parent.left
            anchors.right: parent.right

            PropertyLabel {
                lineHeight: 24
                text: "intValue"
            }

            SpinBox {

                //hack: add some top margin
                anchors.right: parent.right
                anchors.verticalCenterOffset: 8
                anchors.verticalCenter: parent.verticalCenter

                from: 5
                to: 95
                stepSize: 5
                value: 50

                implicitHeight: 32
            }
        }

        PropertyLabel {
            text: "color"
        }

        Item {

            anchors.left: parent.left
            anchors.right: parent.right

            TextField {

                id: colorValue

                implicitHeight: 32

                anchors.left: parent.left
                anchors.right: colorBtn.left
                anchors.rightMargin: 8

                leftPadding: 48

                text: "#137195"

                background: Rectangle {
                    width: parent.width
                    height: parent.height
                    opacity: enabled ? 1 : 0.3
                    border.width: 1
                    border.color: "#BDBDBD"
                    radius: 2
                    color: "white"
                }

                font.pixelSize: 14
                font.family: "Roboto"
                color: "black"
            }

            Rectangle {

                id: colorField

                anchors.verticalCenter: colorValue.verticalCenter

                z: 1

                x: 4

                width: 24
                height: 24

                color: "#137195"

                radius: 2

                MouseArea {
                    anchors.fill: colorField
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onClicked: colorBtn.clicked()
                }
            }

            IconButton {
                id: colorBtn
                anchors.right: parent.right

                z: 3

                icon: "icons/icon_drop.svg"

                onClicked: console.log('TODO: open color picker')
            }
        }
    }
}
