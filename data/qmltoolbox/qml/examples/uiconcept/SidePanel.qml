
import QtQuick 2.0
import QtQuick.Layouts 1.0

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0
import QmlToolbox.PropertyEditor 1.0

Panel
{
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

    Component.onCompleted:
    {
        // hide resizing handle as we have a shadow
        children[1].children[0].visible = false;
    }
}

