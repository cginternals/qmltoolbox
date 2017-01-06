
import QtQuick 2.4
import QtQuick.Controls 1.3

Control {
    id: root

    padding: 10
    
    background: Rectangle {
        color: "#F5F5F5"
    }

    function updateImplicitSize() {
        if (contentItem.children.length == 1) {
            implicitWidth = contentItem.children[0].implicitWidth + leftPadding + rightPadding;
            implicitHeight = contentItem.children[0].implicitHeight + topPadding + bottomPadding;
        }
    }

    Component.onCompleted: {
        root.contentItem.onChildrenChanged.connect(childrenChanged);
        updateImplicitSize();
    }
}