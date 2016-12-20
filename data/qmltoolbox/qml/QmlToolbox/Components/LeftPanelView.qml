
import QtQuick 2.7
import QtQuick.Layouts 1.3

import QtQuick.Controls 1.4 as Controls1

import QmlToolBox.Controls 1.0 as Controls

import Qt.labs.settings 1.0 as Labs

Item {
    id: root

    default property alias mainContent: mainContentWrapper.data
    property alias panelContent: panel.data

    readonly property LayoutPropertiesWidth panel: LayoutPropertiesWidth { }
    readonly property LayoutPropertiesWidth main: LayoutPropertiesWidth { }

    function togglePanel() {
        setPanelVisibility(!isPanelVisible());
    }

    function setPanelVisibility(visible) {
        stateWrapper.state = visible ? "visible" : "hidden";
    }

    function isPanelVisible() {
        return (stateWrapper.state == "visible");
    }

    Controls1.SplitView {
        id: splitView

        anchors.fill: parent
        orientation: Qt.Horizontal

        Item {
            id: mainContentWrapper

            Layout.minimumWidth: root.main.minimumWidth
            Layout.maximumWidth: root.main.maximumWidth
            Layout.preferredWidth: root.main.preferredWidth

            Layout.fillWidth: true
        }

        Item {
            id: panel

            Layout.minimumWidth: root.panel.minimumWidth
            Layout.maximumWidth: root.panel.maximumWidth
            Layout.preferredWidth: root.panel.preferredWidth

            Item {
                id: stateWrapper

                state: "visible"

                states: [
                    State { 
                        name: "visible"
                        PropertyChanges {
                            target: panel
                            Layout.minimumWidth: root.panel.minimumWidth
                            visible: true
                        }
                    },
                    State {
                        name: "hidden"
                        PropertyChanges { 
                            target: panel
                            width: 0
                            Layout.minimumWidth: 0
                            visible: false 
                        }
                    }
                ]

                transitions: [
                    Transition {
                        from: "hidden"; to: "visible" 

                        SequentialAnimation {
                            PropertyAction { properties: "visible" }
                            NumberAnimation { properties: "width"; easing.type: Easing.InOutQuad }
                            PropertyAction { properties: "Layout.minimumWidth" }
                        }
                    },
                    Transition {
                        from: "visible"; to: "hidden"

                        SequentialAnimation {
                            ScriptAction { script: settings.width = panel.width }
                            NumberAnimation { properties: "width"; easing.type: Easing.InOutQuad }
                            PropertyAction { properties: "visible" }
                        }
                    }
                ]
            }

            Labs.Settings {
                id: settings
                category: "leftPanel"
                property bool visible: true
                property int width
            }

            Component.onCompleted: {
                width = settings.width;
                root.setPanelVisibility(settings.visible);
            }

            Component.onDestruction: {
                settings.visible = root.isPanelVisible();

                if (root.isPanelVisible())
                    settings.width = width;
            }
        }
    }
}