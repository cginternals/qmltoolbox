
// import QtQuick 2.4 as QtQuick
import QtQuick 2.4
// import QtQuick.Layouts 1.3
import QtQuick.Layouts 1.1

// import QtQuick.Controls 1.3 as Controls1
import QtQuick.Controls 2.0
import QmlToolBox.Controls 1.0 as Controls
import QmlToolBox.PropertyEditor 1.0 as PropertyEditor

import Qt.labs.settings 1.0 as Labs

Controls.ApplicationWindow
{
    id: window

    visible: true

    x: settings.x
    y: settings.y
    width: settings.width
    height: settings.height

    StackView {
        id: stack

        initialItem: MainPage {}
        anchors.fill: parent
    }

    Labs.Settings {
        id: settings
        property int width: 800
        property int height: 600
        property int x
        property int y
    }

    Component.onDestruction: {
        settings.x = x;
        settings.y = y;
        settings.width = width;
        settings.height = height;
    }
}