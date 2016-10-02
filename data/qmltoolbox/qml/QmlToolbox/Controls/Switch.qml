
import QtQuick 2.0
import QtQuick.Controls 1.1 as Controls

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0


/**
*  Switch
*
*  A switch with a label
*/
Control
{
    id: item

    // Switch text
    property alias text: label.text

    // Switch options
    property alias activeFocusOnPress: sw.activeFocusOnPress
    property alias checked:            sw.checked
    property alias exclusiveGroup:     sw.exclusiveGroup
    property alias style:              sw.style

    implicitWidth:  row.implicitWidth  + 2 * Ui.style.paddingSmall
    implicitHeight: row.implicitHeight + 2 * Ui.style.paddingSmall

    Item
    {
        id: row

        property real spacing: Ui.style.spacingSmall

        anchors.fill:    parent
        anchors.margins: Ui.style.paddingSmall
        implicitWidth:   label.implicitWidth + sw.implicitWidth + spacing + 2 * anchors.margins
        implicitHeight:  Math.max(label.implicitHeight, sw.implicitHeight) + 2 * anchors.margins

        Label
        {
            id: label

            anchors.verticalCenter: parent.verticalCenter

            enabled: item.enabled
        }

        Controls.Switch
        {
            id: sw

            anchors.right:          parent.right
            anchors.verticalCenter: parent.verticalCenter

            onCheckedChanged:
            {
                item.clicked();
            }
        }
    }
}
