
import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0

import QmlToolBox.Base 1.0


/**
*  Switch
*
*  Implementation of Switch using Controls 1.2
*/
Item
{
    property alias checked: switch_item.checked
    property alias text: switch_label.text

    implicitHeight: switch_layout.implicitHeight
    implicitWidth: switch_layout.implicitWidth

    signal clicked()


    MouseArea
    {
        id: switch_mouse

        anchors.fill: parent

        propagateComposedEvents: true

        onClicked:
        {
            switch_item.checked = !switch_item.checked
        }

        RowLayout
        {
            anchors.fill: parent
            id: switch_layout
        
            Switch { id: switch_item }

            Label { id: switch_label }
        }
    }

    Component.onCompleted: 
    {
        switch_mouse.clicked.connect(clicked);
        switch_item.clicked.connect(clicked);
    }

    DebugItem { }
}
