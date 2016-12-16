
import QtQuick 2.7
import QtQuick.Layouts 1.3

import QtQuick.Controls 2.0
import QmlToolBox.Controls 1.0


/**
*  AutocompletePopup
*
*  This item shows a list of configurable labels within a popup that intended 
*  for autocompletion.
*/
Popup 
{
    id: root

    signal selected(int index)

    // Max visible elements ...
    property int maxVisibleElements: 4

    // Model ...
    property alias model: list_view.model

    // List .. 
    property alias list: list_view

    width: 200
    height: calculateHeight()

    padding: 0
    closePolicy: Popup.CloseOnPressOutside

    Label 
    { 
        id: font_label 
    }

    ListView 
    {
        id: list_view

        anchors.fill: parent

        verticalLayoutDirection: ListView.BottomToTop
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        ScrollIndicator.vertical: ScrollIndicator 
        { 
        }

        delegate: ItemDelegate 
        {
            width: parent.width
            height: root.rowHeight()
            topPadding: 0
            bottomPadding: 0

            text: keyword
            highlighted: ListView.isCurrentItem

            onClicked: list_view.select(index)
        }

        Keys.onReturnPressed: 
        {
            select(currentIndex);
            event.accepted = true;
        }

        Keys.onEscapePressed: 
        {
            root.close();
        }

        function select(index) 
        {
            root.selected(index);
            root.close();
        }
    }

    /**
    *  Retrieve height of single row in pixels
    */
    function rowHeight() 
    {
        return font_label.font.pixelSize * 2.0;
    }

    /**
    *  Calculate height of this popup based on number of currently visible or
    *  maximum visible items.
    */
    function calculateHeight()
    {
        var count = Math.min(model.count, maxVisibleElements);
        return count * rowHeight();
    }
}
