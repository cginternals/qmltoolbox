
import QtQuick 2.4
import QtQuick.Layouts 1.1

import QtQuick.Controls 1.3 as Controls1

import QmlToolBox.Controls 1.0 as Controls

import Qt.labs.settings 1.0 as Labs

/**
*  BottomPanelView
*
*  This item implements a resizable and collapsible bottom panel.
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
    readonly property LayoutPropertiesHeight panel: LayoutPropertiesHeight { }
    readonly property LayoutPropertiesHeight main: LayoutPropertiesHeight { }

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
        orientation: Qt.Vertical
        
        Item 
        {
            id: mainContentWrapper

            Layout.minimumHeight: root.main.minimumHeight
            Layout.maximumHeight: root.main.maximumHeight
            Layout.preferredHeight: root.main.preferredHeight

            Layout.fillHeight: true
        }

        Item 
        {
            id: panel

            Layout.minimumHeight: root.panel.minimumHeight
            Layout.maximumHeight: root.panel.maximumHeight
            Layout.preferredHeight: root.panel.preferredHeight

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
                            Layout.minimumHeight: root.panel.minimumHeight
                            visible: true
                        }
                    },
                    State 
                    {
                        name: "hidden"
                        PropertyChanges 
                        { 
                            target: panel
                            height: 0
                            Layout.minimumHeight: 0
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
                            NumberAnimation { properties: "height"; easing.type: Easing.InOutQuad }
                            PropertyAction { properties: "Layout.minimumHeight" }
                        }
                    },
                    Transition 
                    {
                        from: "visible"; to: "hidden"

                        SequentialAnimation 
                        {
                            ScriptAction { script: settings.height = panel.height }
                            NumberAnimation { properties: "height"; easing.type: Easing.InOutQuad }
                            PropertyAction { properties: "visible" }
                        }
                    }
                ]
            }

            Labs.Settings 
            {
                id: settings
                category: "bottomPanel"
                property bool visible: true
                property int height
            }

            Component.onCompleted: 
            {
                height = settings.height;
                root.setPanelVisibility(settings.visible);
            }

            Component.onDestruction: 
            {
                settings.visible = root.isPanelVisible();

                if (root.isPanelVisible())
                    settings.height = height;
            }
        }
    }
}