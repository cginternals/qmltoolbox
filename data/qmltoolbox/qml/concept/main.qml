import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

// TODO
// global variables (main color, accent colors)
// normalize margins into 8px grid system

ApplicationWindow {
    visible: true
    width: 1080
    height: 650
    title: qsTr("gloperate")

    //load fonts
    FontLoader { source: "fonts/Inconsolata-Regular.ttf" }
    FontLoader { source: "fonts/Inconsolata-Bold.ttf" }

    FontLoader { source: "fonts/Roboto-Regular.ttf" }
    FontLoader { source: "fonts/Roboto-Medium.ttf" }

    FontLoader { source: "fonts/Montserrat-Regular.ttf" }
    FontLoader { source: "fonts/Montserrat-Light.ttf" }

    //global styles
    QtObject {
        id: style
        property color backgroundColor: "#f1f1f1"
    }

    background: Rectangle {
        anchors.fill: parent
        color: style.backgroundColor
    }

    header: Topbar {
        id: topBar
    }

    WelcomeScreen {
        id: welcomeScreen
        visible: false
    }

    StackLayout {
        id: stackLayout
        anchors.fill: parent
        currentIndex: topBar.tabIndex
        z: -1

        Viewer {
        }

        Page {
        }

        Page {
        }
    }

    SettingsDialog {
        id: settingsDialog
    }

    Component.onCompleted: function() {
        topBar.tabIndex = 0;
    }
}
