
import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.3
import QtQuick.Controls.Private 1.0

import QmlToolbox.Base 1.0


/**
*  ComboBox
*
*  Text input with optional dropdown menu, can also display a list of images
*
*  Implementation of ComboBox using Controls 1.0
*/
ComboBox 
{
    id: input

    property var pixmaps: null ///< List of image URLs for each element (must match the length of model)

    style: pixmaps !== null ? pixmapStyle : defaultStyle

    DebugItem
    {
    }

    Component
    {
        id: pixmapStyle

        ComboBoxStyle
        {
            label: Image
            {
                id: image

                source: input.pixmaps[input.currentIndex]
            }

            // Drop-down customization
            property Component __dropDownStyle: MenuStyle
            {
                __maxPopupHeight: 600
                __menuItemType: "comboboxitem"

                itemDelegate.label: Image
                {
                    id: image

                    width:  input.width
                    height: input.height
                    source: input.pixmaps[styleData.index]
                }
            }
        }
    }

    Component
    {
        id: defaultStyle

        ComboBoxStyle
        {
        }
    }
}
