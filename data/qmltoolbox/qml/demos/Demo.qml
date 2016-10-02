
import QtQuick 2.0

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0
import QmlToolbox.Ui 1.0
import QmlToolbox.PipelineEditor 1.0


Item
{
    id: root

    // UI status
    property real uiStatus: 1.0

    readonly property bool uiEnabled: uiStatus > 0.0

    Behavior on uiStatus
    {
        NumberAnimation
        {
            easing.type: Easing.InOutQuad
            duration:    1000
        }
    }

    // Hide all UI elements on Escape
    Keys.onPressed:
    {
        if (event.key == Qt.Key_Escape)
        {
            // Show/hide UI elements
            if (uiStatus > 0.0) {
                uiStatus = 0.0;
                tabs.selected = '';
            } else {
                uiStatus = 1.0;
            }
        }
    }

    implicitWidth:  800
    implicitHeight: 600
    focus:          true

    // Colored background
    Background
    {
        anchors.fill: parent
    }

    // Main menu (top-left)
    ButtonBar
    {
        id: leftButtons

        anchors.left:    parent.left
        anchors.top:     parent.top
        anchors.margins: Ui.style.paddingMedium

        visible: root.uiEnabled

        ButtonMenu
        {
            text: 'Homes'
            icon: '0001-home.png'

            IconButton
            {
                text: 'Home1'
                icon: '0001-home.png'
            }

            IconButton
            {
                text: 'Home2'
                icon: '0002-home2.png'
            }

            IconButton
            {
                text: 'Home3'
                icon: '0003-home3.png'
                enabled: false
            }
        }

        IconButton
        {
            text: 'Back'
            icon: '0263-point-left.png'
        }
    }

    // Second menu (top-right)
    ButtonBar
    {
        id: rightButtons

        anchors.right:   parent.right
        anchors.top:     parent.top
        anchors.margins: Ui.style.paddingMedium

        visible: root.uiEnabled

        IconButton
        {
            text: 'Settings'
            icon: '0146-wrench.png'

            onClicked:
            {
                settings.createObject(null, { visible: true });
            }
        }

        IconButton
        {
            text: 'Dialog'
            icon: '0339-checkbox-checked.png'

            onClicked:
            {
                dialog.show();
            }
        }
    }

    // Main content
    PipelineEditor
    {
        id: pipelineEditor

        anchors.left:    parent.left
        anchors.right:   parent.right
        anchors.top:     leftButtons.bottom
        anchors.bottom:  tabs.top
        anchors.margins: Ui.style.paddingMedium

        pipelineInterface: DemoPipelineInterface
        {
        }
    }

    // Panel buttons (bottom-left)
    ButtonBar
    {
        id: tabs

        anchors.bottom:  panelBottom.top
        anchors.left:    parent.left
        anchors.margins: Ui.style.paddingSmall
        spacing:         Ui.style.spacingSmall

        visible: root.uiEnabled
        opacity: root.uiStatus

        property string selected: ''

        IconButton
        {
            property string title: 'log'

            icon:     '0035-file-text.png'
            selected: tabs.selected == title

            onClicked:
            {
                if (tabs.selected != title) tabs.selected = title;
                else                        tabs.selected = '';
            }
        }

        IconButton
        {
            property string title: 'script'

            icon:     '0086-keyboard.png'
            selected: tabs.selected == title

            onClicked:
            {
                if (tabs.selected != title) tabs.selected = title;
                else                        tabs.selected = '';
            }
        }
    }

    // Panels
    Frame
    {
        id: panelBottom

        anchors.left:         root.left
        anchors.right:        root.right
        anchors.bottom:       root.bottom
        anchors.leftMargin:   Ui.style.paddingSmall
        anchors.rightMargin:  Ui.style.paddingSmall
        anchors.bottomMargin: status * (height + Ui.style.paddingSmall) - height
        height:               root.height / 3

        visible: root.uiEnabled
        opacity: root.uiStatus

        property real status: (tabs.selected != '') ? 1.0 : 0.0

        Behavior on status
        {
            NumberAnimation
            {
                easing.type: Easing.InOutQuad
                duration:    600
            }
        }

        LogView
        {
            anchors.fill: parent

            visible: tabs.selected == 'log'
        }

        ScriptConsole
        {
            anchors.fill:    parent
            anchors.margins: Ui.style.paddingMedium

            visible: tabs.selected == 'script'
        }
    }

    // Settings dialog
    Component
    {
        id: settings

        Settings
        {
        }
    }

    // Demo dialog
    DemoDialog
    {
        id: dialog

        width: 600
    }

    Component.onCompleted:
    {
        pipelineEditor.load();
    }
}
