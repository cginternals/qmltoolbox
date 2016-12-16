
// import QtQuick 2.4 as QtQuick
import QtQuick 2.4
// import QtQuick.Layouts 1.3
import QtQuick.Layouts 1.1

// import QtQuick.Controls 1.3 as Controls1
// import QtQuick.Controls 2.0
import QmlToolBox.Controls2 1.0 as Controls
import QmlToolBox.PropertyEditor 1.0 as PropertyEditor

Controls.ApplicationWindow
{
    id: window
    width: 800
    height: 600
    visible: true

    StackView {
        id: stack

        initialItem: MainPage {}
        anchors.fill: parent
    }
}