
import QtQuick 2.7
import QtQuick.Layouts 1.3

import QtQuick.Controls 1.4 as Controls1
import QtQuick.Controls 2.0
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