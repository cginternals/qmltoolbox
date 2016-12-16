
import QtQuick 2.4
import QtQuick.Controls 1.3

Item {
    property alias checked: switch_item.checked

    implicitHeight: switch_item.implicitHeight
    implicitWidth: switch_item.implicitWidth

    signal clicked()

    Switch {
        id: switch_item

        anchors.fill: parent
    }

    Component.onCompleted: {
        switch_item.clicked.connect(clicked);
    }
}