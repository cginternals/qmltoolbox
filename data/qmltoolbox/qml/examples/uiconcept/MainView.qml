
import QtQuick 2.0
import QtQuick.Layouts 1.0

import QmlToolbox.Base 1.0
import QmlToolbox.PropertyEditor 1.0
import QmlToolbox.Controls 1.0

Item
{
    Rectangle
    {
        id: background

        anchors.left:   sidePanel.position == 'left' ? sidePanel.right : parent.left
        anchors.right:  sidePanel.position == 'left' ? parent.right : sidePanel.left
        anchors.top:    parent.top
        anchors.bottom: parent.bottom

        color: Ui.style.backgroundColor
    }

    // screenshot & video tool, "show sidebar" button
    ToolButtonRow
    {
        id: toolButtonRow

        anchors.top: parent.top
        anchors.topMargin: 12
        anchors.leftMargin: 16
        anchors.rightMargin: 16
    }

    // "show console" button
    LabelButton
    {
        id: consoleButton

        text: "Show Console"
        anchors.bottom: parent.bottom
        anchors.left: sidePanel.position == 'left' ? sidePanel.right : parent.left
        anchors.leftMargin: 8
        anchors.bottomMargin: 8

        visible: !bottomPanel.isVisible()

        onClicked: bottomPanel.setVisible(true)
    }

    // Side Panel
    Panel
    {
        id: sidePanel

        position:    settings.panelPosition
        minimumSize: 240

        // caption & close button
        RowLayout
        {
            id: sideCaption

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top

            anchors.leftMargin: 8
            anchors.rightMargin: 8

            Label
            {
                text: "Properties"
                font: Ui.style.mainFont
                color: Ui.style.dimHeadlineColor
            }

            Item
            {
                Layout.fillWidth: true
            }

            ToolButton
            {
                contentItem: Image
                {
                    source: "icons/icon_close_sidebar.svg"
                }

                background.visible: hovered

                onClicked: sidePanel.setVisible(false)
            }
        }

        // actual properties
        ScrollArea
        {
            id: scrollArea

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: sideCaption.bottom
            anchors.bottom: parent.bottom

            contentHeight: propertyEditor.height

            flickableDirection: Flickable.VerticalFlick
            boundsBehavior:     Flickable.StopAtBounds

            PropertyEditor
            {
                id: propertyEditor

                width: scrollArea.width

                properties: demoProperties
                path:       'root'

                Component.onCompleted:
                {
                    propertyEditor.update()
                }
            }
        }
    }

    function setSidePanelVisible(vis)
    {
        sidePanel.visible = vis
    }

    function hideAllTools()
    {
        sidePanel.visible = false;
        consoleButton.visible = false;
        toolButtonRow.visible = false;
    }

    function unhideAllTools()
    {
        sidePanel.visible = true;
        toolButtonRow.visible = true;

        consoleButton.visible = Qt.binding(function() { return !bottomPanel.isVisible(); });
    }
}
