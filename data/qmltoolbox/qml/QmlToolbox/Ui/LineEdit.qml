
import QtQuick 2.0

import QmlToolbox.Base 1.0


/**
*  LineEdit
*
*  Single-line editable text
*/
Rectangle
{
    id: item

    signal textEdited(string text)
    signal accepted()

    property string text:            ''
    property string placeholderText: ''
    property bool   readOnly:        false
    property bool   selectByMouse:   true
    property color  backgroundColor: 'transparent'
    property color  textColor:       Ui.style.textColor
    property int    textSize:        Ui.style.fontSizeMedium

    implicitWidth:  input.implicitWidth
    implicitHeight: input.implicitHeight

    color: backgroundColor

    /* [TODO]
    TextController
    {
        id: controller

        target: input
    }
    */

    TextEdit
    {
        id: input

        width:           parent.width
        font.pixelSize:  item.textSize
        text:            item.text
        readOnly:        item.readOnly
        selectByMouse:   item.selectByMouse
        color:           item.textColor

        onTextChanged:
        {
            if (text != item.text)
            {
                textEdited(text);
                item.text = text;
            }
        }

        Keys.onEnterPressed:
        {
            item.accepted();
        }

        /*
          Without this code, the editor respects the original distinction between Return
          and Enter: Return creates a new line, while Enter executes the code.
          However, this behaviour may be unfamiliar to most user. Uncomment this to
          enable the alternative mapping: Shift-Return creates a new line, Return and Enter
          execute the code.
        */
        Keys.onReturnPressed:
        {
            if ((event.modifiers & Qt.ShiftModifier) == 0) {
                item.accepted();
            } else {
                event.accepted = false;
            }
        }
    }
}
