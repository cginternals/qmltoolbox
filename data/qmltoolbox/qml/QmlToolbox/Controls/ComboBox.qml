
import QtQuick 2.4
import QtQuick.Controls 2.0

import QmlToolbox.Base 1.0


/**
*  ComboBox
*
*  Text input with optional dropdown menu
*
*  Default implementation of ComboBox using Controls 2.0
*/
ComboBox 
{
    id: comboBox

    property bool isImagedDisplayed: false;

    function displayImage()
    {
        comboBox.delegate = delegate;
        comboBox.contentItem = contentItem.createObject(comboBox, {});
        comboBox.isImagedDisplayed = true;
    }

    DebugItem
    {
    }

    Component {
        id: delegate;
        ItemDelegate {
            width: input.width
            contentItem: Image {
                width: input.width
                height: input.height
                source: modelData.image
            }
            highlighted: input.highlightedIndex === input.index
        }
    }

    Component {
        id: contentItem;
        Image {
            width: input.width
            height: input.height
            source: input.model[input.currentIndex].image
        }
    }

}
