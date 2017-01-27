
import QtQuick 2.4
import QtQuick.Layouts 1.1

import QtQuick.Controls 1.3

ScrollView {
    id: root

    // TODO: Should be list<Item>
    default property Item content

    property alias boundsBehavior: flickable.boundsBehavior
    property alias contentHeight: flickable.contentHeight
    property alias contentWidth: flickable.contentWidth
    property alias contentX: flickable.contentX
    property alias contentY: flickable.contentY

    property var scrollBarColor: null
    property var flickableDirection: null

    property bool verticalScrollbar: false
    property bool horizontalScrollbar: false

    onVerticalScrollbarChanged: {
        root.verticalScrollBarPolicy = verticalScrollbar ? Qt.ScrollBarAlwaysOn : Qt.ScrollBarAlwaysOff;
    }

    onHorizontalScrollbarChanged: {
        root.horizontalScrollBarPolicy = horizontalScrollbar ? Qt.ScrollBarAlwaysOn : Qt.ScrollBarAlwaysOff;
    }

    onContentChanged: {
        if (content !== null) {
            content.parent = flickable.contentItem;
        }
    }

    Flickable { id: flickable }
}