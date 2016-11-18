
import QtQuick 2.7
import QtQuick.Layouts 1.3

import QmlToolBox.Controls2 1.0 as Controls

import Qt.labs.settings 1.0 as Labs

Controls.Pane {
    id: bottomPanel

    function toggle() {
        setVisibility(!isVisible());
    }

    function setVisibility(visible) {
        stateWrapper.state = visible ? "visible" : "hidden";
    }

    function isVisible() {
        return (stateWrapper.state == "visible");
    }

    padding: 0.0
    Layout.minimumHeight: 150

    Item {
        id: stateWrapper

        state: "visible"

        states: [
            State { 
                name: "visible"
                PropertyChanges {
                    target: bottomPanel
                    visible: true
                }
            },
            State {
                name: "hidden"
                PropertyChanges { 
                    target: bottomPanel
                    height: 0
                    Layout.minimumHeight: 0
                    visible: false 
                }
            }
        ]

        transitions: [
            Transition {
                from: "hidden"; to: "visible" 

                SequentialAnimation {
                    PropertyAction { properties: "visible" }
                    NumberAnimation { properties: "height"; easing.type: Easing.InOutQuad }
                    PropertyAction { properties: "Layout.minimumHeight" }
                }
            },
            Transition {
                from: "visible"; to: "hidden"

                SequentialAnimation {
                    ScriptAction { script: settings.height = bottomPanel.height }
                    NumberAnimation { properties: "height"; easing.type: Easing.InOutQuad }
                    PropertyAction { properties: "visible" }
                }
            }
        ]
    }

    Labs.Settings {
        id: settings
        category: "bottomPanel"
        property bool visible: true
        property int height
    }

    Component.onCompleted: {
        height = settings.height;
        setVisibility(settings.visible);
    }

    Component.onDestruction: {
        settings.visible = isVisible();

        if (isVisible())
            settings.height = height;
    }
}