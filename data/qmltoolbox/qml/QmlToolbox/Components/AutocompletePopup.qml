
import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0


/**
*  AutocompletePopup
*
*  This item shows a list of configurable labels within
*  a popup intended for autocompletion.
*/
Popup
{
    id: item

    signal selected(int index)

    property int   maxVisibleElements: 6
    property alias model:              list.model
    property alias listItem:           list

    width:  200
    height: calculateHeight()

    padding:     0
    closePolicy: Popup.CloseOnPressOutside

    Label
    {
        id: label
    }

    ListView
    {
        id: list

        anchors.fill: parent

        verticalLayoutDirection: ListView.BottomToTop
        boundsBehavior:          Flickable.StopAtBounds
        clip:                    true

        ScrollIndicator.vertical: ScrollIndicator
        {
        }

        delegate: ItemDelegate
        {
            width:  parent.width
            height: item.rowHeight()

            topPadding:    0
            bottomPadding: 0

            text:        modelData
            highlighted: ListView.isCurrentItem

            onClicked:
            {
                list.select(index);
            }
        }

        Keys.onReturnPressed:
        {
            select(currentIndex);
            event.accepted = true;
        }

        Keys.onEscapePressed:
        {
            item.close();
        }

        function select(index)
        {
            item.selected(index);
            item.close();
        }
    }

    function rowHeight()
    {
        return label.font.pixelSize * 2.0;
    }

    function calculateHeight()
    {
        var count = Math.min(model.length, maxVisibleElements);
        return count * rowHeight();
    }
}
