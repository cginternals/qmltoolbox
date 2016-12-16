
import QtQuick 2.7
import QtQuick.Layouts 1.3

import QtQuick.Controls 2.0
import QmlToolBox.Controls2 1.0 as Controls

Popup {
    id: root

    property int maxVisibleElements: 3
    property alias model: list_view.model
    property alias list: list_view

    function rowHeight() {
        return font_label.font.pixelSize * 2.0;
    }

    signal selected(int index)

    padding: 0
    width: 200

    height: { 
        var count = Math.min(model.count, maxVisibleElements);
        return count * rowHeight();
    }

    Label { id: font_label }

    closePolicy: Popup.CloseOnPressOutside

    ListView {
        id: list_view

        function select(index) {
            root.selected(index);
            root.close();
        }

        anchors.fill: parent

        clip: true
        boundsBehavior: Flickable.StopAtBounds
        verticalLayoutDirection: ListView.BottomToTop

        delegate: ItemDelegate {
            text: keyword

            width: parent.width
            height: root.rowHeight()
            bottomPadding: 0
            topPadding: 0

            font.family: "Menlo"

            highlighted: ListView.isCurrentItem

            onClicked: list_view.select(index)
        }

        ScrollIndicator.vertical: ScrollIndicator { }

        Keys.onReturnPressed: {
            select(currentIndex);
            event.accepted = true;
        }

        Keys.onEscapePressed: {
            root.close();
        }
    }
}