
import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0

import QmlToolbox.Base 1.0


/**
*  Switch
*
*  Two-state toggle switch
*
*  Implementation of Switch using Controls 1.2
*/
Item
{
    id: item

    property alias checked: sw.checked
    property alias text:    label.text

    implicitHeight: row.implicitHeight
    implicitWidth:  row.implicitWidth

    signal clicked()

    RowLayout
    {
        id: row

        anchors.fill: parent
    
        Switch
        {
            id: sw

            onClicked:
            {
                item.clicked();
            }
        }

        Label
        {
            id: label
        }
    }

    DebugItem
    {
    }
}
