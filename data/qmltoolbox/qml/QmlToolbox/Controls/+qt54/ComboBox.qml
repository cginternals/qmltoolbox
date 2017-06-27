
import QtQuick 2.4
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.3
import QtQuick.Controls.Private 1.0

import QmlToolbox.Base 1.0


/**
*  ComboBox
*
*  Text input with optional dropdown menu
*
*  Implementation of ComboBox using Controls 1.0
*/
ComboBox 
{
    id: input

    property var pixmaps: null;

    function displayPixmaps(pixmapList)
    {
        input.pixmaps = pixmapList;
        input.style = comboBoxStyle;
    }

    DebugItem
    {
    }

    Component {
        id: comboBoxStyle;
        ComboBoxStyle {
            label: Image {
                id: image
                source: input.pixmaps[input.currentIndex]
            }

            // drop-down customization
            property Component __dropDownStyle: MenuStyle {
                __maxPopupHeight: 600
                __menuItemType: "comboboxitem"

                itemDelegate.label: Image {
                    id: image
                    source: input.pixmaps[styleData.index]
                }
            }
        }
    }
}
