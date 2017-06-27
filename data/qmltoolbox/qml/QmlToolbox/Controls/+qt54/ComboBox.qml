
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
    id: comboBox

    property bool isImagedDisplayed: false;

    function displayImage()
    {
        comboBox.style = comboBoxStyle;
        comboBox.isImagedDisplayed = true;
    }

    DebugItem
    {
    }

    Component {
        id: comboBoxStyle;
        ComboBoxStyle {
            label: Image {
                id: image
                source: comboBox.model[comboBox.currentIndex].image
            }

            // drop-down customization
            property Component __dropDownStyle: MenuStyle {
                __maxPopupHeight: 600
                __menuItemType: "comboboxitem"

                itemDelegate.label: Image {
                    id: image
                    source: comboBox.model[styleData.index].image
                }
            }
        }
    }
}
