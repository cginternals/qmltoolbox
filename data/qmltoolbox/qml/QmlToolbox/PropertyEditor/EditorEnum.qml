
import QtQuick 2.4

import QmlToolbox.Controls 1.0


/**
*  EditorEnum
*
*  Editor for properties of type 'enum'
*/
Editor
{
    id: item

    implicitWidth:  input.implicitWidth
    implicitHeight: input.implicitHeight

    ComboBox
    {
        id: input

        anchors.fill: parent

        onActivated:
        {
            item.properties.setValue(item.path, item.slot, input.isImagedDisplayed ? input.model[index].text : input.model[index]);
        }
    }

    onStatusChanged:
    {
        if (!status.hasOwnProperty('choices')) {
            input.model = null;
            input.currentIndex = -1;
             return;
         }
 
         input.model = status.choices;
         input.currentIndex = status.choices.indexOf(status.value);

         if (!status.hasOwnProperty('pixmaps')) {
            input.model = status.choices;
            return;
        }

        var model = []
        for (var i = 0; i < status.choices.length; i++)
        {
            var element = {}
            element.text = status.choices[i];
            element.image = status.pixmaps[i];
            model.push(element);
        }

        input.model = model;
        input.displayImage();
    }
}
