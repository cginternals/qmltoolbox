
import QtQuick 2.4
import QtQuick.Controls 1.3

Control {
    id: root

    padding: 10
    
    background: Rectangle {
        color: "#F5F5F5"
    }

    /**
    *  Implements the following specification:
    *  If only a single item is used within a Pane, it will resize to fit the implicit size of its contained item.     
    */
    function updateImplicitSize() {
        if (contentItem.children.length == 1) {
            implicitWidth = Qt.binding(function() { return contentItem.children[0].implicitWidth + leftPadding + rightPadding });
            implicitHeight = Qt.binding(function() { return contentItem.children[0].implicitHeight + topPadding + bottomPadding });
        }
    }

    Component.onCompleted: {
        root.contentItem.onChildrenChanged.connect(childrenChanged);
        updateImplicitSize();
    }
}