
import QtQuick 2.4
import QtQuick.Controls 1.3

/**
*  Button
*
*  Fallback implementation of Button using Controls 1.3
*  This implementation wraps the button with an item to 
*  prevent property conflicts and partially matches the
*  required button interface of Controls 2.0.
*/
Item
{
    property alias text: button.text
    property bool flat: true
    property bool highlighted: true

    implicitHeight: button.implicitHeight
    implicitWidth: button.implicitWidth

    signal clicked()

    Button 
    {
        id: button

        anchors.fill: parent

        onClicked: parent.clicked()
    }
}
