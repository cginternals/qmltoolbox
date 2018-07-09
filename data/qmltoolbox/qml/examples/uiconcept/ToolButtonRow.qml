
import QtQuick 2.0

import QmlToolbox.Controls 1.0

Row
{
    spacing: 8

    // states with anchor changes to avoid positioning bugs
    states:
    [
        State
        {
            name: "anchoredLeftPanel"
            when: sidePanel.isVisible() && sidePanel.position == 'left'

            AnchorChanges
            {
                target: toolButtonRow
                anchors.right: undefined
                anchors.left: sidePanel.right
            }
        },
        State
        {
            name: "anchoredLeftViewer"
            when: !sidePanel.isVisible() && sidePanel.position == 'left'

            AnchorChanges
            {
                target: toolButtonRow
                anchors.right: undefined
                anchors.left: mainView.left
            }
        },
        State
        {
            name: "anchoredRightPanel"
            when: sidePanel.isVisible() && sidePanel.position == 'right'

            AnchorChanges
            {
                target: toolButtonRow
                anchors.left: undefined
                anchors.right: sidePanel.left
            }
        },
        State
        {
            name: "anchoredRightViewer"
            when: !sidePanel.isVisible() && sidePanel.position == 'right'

            AnchorChanges
            {
                target: toolButtonRow
                anchors.left: undefined
                anchors.right: mainView.right
            }
        }
    ]

    // left side panel
    LabelButton
    {
        text: "Show Side Panel"
        visible: !sidePanel.isVisible() && sidePanel.position == 'left'
        anchors.verticalCenter: parent.verticalCenter

        onClicked: sidePanel.setVisible(true)
    }

    // screenshot
    ToolButton
    {
        contentItem: Image
        {
            source: "icons/ic_photo_camera_black_24px.svg"

            width: 24
            height: 24
        }

        background.visible: false
    }

    // video
    ToolButton
    {
        contentItem: Image
        {
            source: "icons/ic_videocam_black_24px.svg"

            width: 24
            height: 24
        }

        background.visible: false
    }

    // right side panel
    LabelButton
    {
        text: "Show Side Panel"
        visible: !sidePanel.isVisible() && sidePanel.position == 'right'
        anchors.verticalCenter: parent.verticalCenter

        onClicked: sidePanel.setVisible(true)
    }
}
