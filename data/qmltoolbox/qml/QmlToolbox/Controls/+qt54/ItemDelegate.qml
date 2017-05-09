
import QtQuick 2.4
import QtQuick.Controls 1.1

import QmlToolbox.Base 1.0
    

/**
*  ItemDelegate
*
*  Delegate for showing items in a list
*
*  Default implementation of Slider using Controls 1.1
*/
Item
{
    id: item

    signal clicked()

    property bool   highlighted: false
    property string text:        ''

    property int padding:       Ui.style.smallPadding
    property int leftPadding:   padding
    property int rightPadding:  padding
    property int topPadding:    padding
    property int bottomPadding: padding

    Rectangle
    {
        anchors.fill: parent

        color: item.highlighted ? Ui.style.itemColorHighlighted : Ui.style.itemColor

        Label
        {
            anchors.fill:    parent
            anchors.margins: item.padding

            text: item.text
        }
    }

    DebugItem
    {
    }
}
