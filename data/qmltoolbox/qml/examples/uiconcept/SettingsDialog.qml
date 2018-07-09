import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0

Popup {

    id: popup

    property var settings: null

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

    contentItem: GridLayout
    {
        id: grid

        anchors.fill: parent
        anchors.margins: 16

        columns:       2
        columnSpacing: 16
        rowSpacing:    8

        Label
        {
            text: qsTr('Settings')
            font: Ui.style.headlineFont
            color: Ui.style.headlineColor

            Layout.columnSpan: 2
        }

        Label
        {
            Layout.alignment: Qt.AlignRight

            text: 'Enable Debug Mode'
        }

        Switch
        {
            text: ''
            checked: settings.debugMode

            onClicked:
            {
                settings.debugMode = !settings.debugMode;
            }
        }

        Label
        {
            Layout.alignment: Qt.AlignRight

            text: 'Panel Position'
        }

        ComboBox
        {
            model: [ 'left', 'right' ]

            currentIndex: model.indexOf(settings.panelPosition)

            onActivated:
            {
                var position = model[index];
                settings.panelPosition = position;
            }
        }

        Item
        {
            Layout.columnSpan: 2
            Layout.fillHeight: true
        }
    }

    Label {
        id: acceptButton

        topPadding: 8
        bottomPadding: 8
        rightPadding: 16
        leftPadding: 16

        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.rightMargin: -rightPadding
        anchors.bottomMargin: -bottomPadding

        color: Ui.style.textSignalColor
        text: "Done"
        font: Ui.style.dialogOptionFont
    }

    MouseArea {
        anchors.fill: acceptButton
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: popup.close()
    }
}
