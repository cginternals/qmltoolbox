
import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3 as Controls1

import QmlToolbox.Controls 1.0 as Controls


/**
*  LeftPanelView
*
*  This item implements a resizable and collapsible left panel.
*/
Item 
{
    id: root

    // Main content (outside of panel)
    default property alias mainContent: mainContentWrapper.data

    // Content of the panel
    property alias panelContent: panel.data

    /**
     * Set the following properties for both the main content 
     * and the content of the panel:
     * - minimumWidth
     * - maximumWidth
     * - preferredWidth
     */
    readonly property LayoutPropertiesWidth panel: LayoutPropertiesWidth { }
    readonly property LayoutPropertiesWidth main: LayoutPropertiesWidth { }

    function togglePanel() 
    {
        setPanelVisibility(!isPanelVisible());
    }

    function setPanelVisibility(visible) 
    {
        stateWrapper.state = visible ? "visible" : "hidden";
    }

    function isPanelVisible() 
    {
        return (stateWrapper.state == "visible");
    }

    Controls1.SplitView 
    {
        id: splitView

        anchors.fill: parent
        orientation: Qt.Horizontal

        Item 
        {
            id: mainContentWrapper

            Layout.minimumWidth: root.main.minimumWidth
            Layout.maximumWidth: root.main.maximumWidth
            Layout.preferredWidth: root.main.preferredWidth

            Layout.fillWidth: true
        }

        Item 
        {
            id: panel

            Layout.minimumWidth: root.panel.minimumWidth
            Layout.maximumWidth: root.panel.maximumWidth
            Layout.preferredWidth: root.panel.preferredWidth

            Item 
            {
                id: stateWrapper

                state: "visible"

                states: 
                [
                    State 
                    { 
                        name: "visible"
                        PropertyChanges 
                        {
                            target: panel
                            Layout.minimumWidth: root.panel.minimumWidth
                            visible: true
                        }
                    },
                    State 
                    {
                        name: "hidden"
                        PropertyChanges 
                        { 
                            target: panel
                            width: 0
                            Layout.minimumWidth: 0
                            visible: false 
                        }
                    }
                ]

                transitions: 
                [
                    Transition 
                    {
                        from: "hidden"; to: "visible" 

                        SequentialAnimation 
                        {
                            PropertyAction { properties: "visible" }
                            NumberAnimation { properties: "width"; easing.type: Easing.InOutQuad }
                            PropertyAction { properties: "Layout.minimumWidth" }
                        }
                    },
                    Transition 
                    {
                        from: "visible"; to: "hidden"

                        SequentialAnimation 
                        {
                            ScriptAction { script: settings.width = panel.width }
                            NumberAnimation { properties: "width"; easing.type: Easing.InOutQuad }
                            PropertyAction { properties: "visible" }
                        }
                    }
                ]
            }

//          Labs.Settings
            QtObject
            {
                id: settings

                property string category: "leftPanel"
                property bool visible: true
                property int width
            }

            Component.onCompleted: 
            {
                width = settings.width;
                root.setPanelVisibility(settings.visible);
            }

            Component.onDestruction: 
            {
                settings.visible = root.isPanelVisible();

                if (root.isPanelVisible())
                    settings.width = width;
            }
        }
    }
}
