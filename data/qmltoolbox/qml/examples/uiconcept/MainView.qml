
import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0

import QmlToolbox.Base 1.0
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

    // side panel & its shadow
    // has to be done here to be able to draw beyond sidebar extends
    RectangularGlow
    {
        id: sidePanelShadow

        anchors.horizontalCenter: sidePanelBackground.horizontalCenter
        anchors.verticalCenter: sidePanelBackground.verticalCenter
        width: sidePanelBackground.width + 2*Ui.style.shadowRadius
        height: sidePanelBackground.height + 2*Ui.style.shadowRadius
        visible: sidePanel.isVisible()

        glowRadius: Ui.style.shadowRadius
        color: Ui.style.shadowColor
    }

    Rectangle
    {
        id: sidePanelBackground

        color: Ui.style.backgroundColor
        anchors.fill: sidePanel
    }

    SidePanel
    {
        id: sidePanel

        position:    settings.panelPosition
        minimumSize: 240
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
        anchors.margins: 16

        visible: !bottomPanel.isVisible()

        onClicked: bottomPanel.setVisible(true)
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
