
import QtQuick 2.0
import QtQuick.Controls 1.0

import QmlToolbox.Base 1.0


/**
*  TextArea
*
*  Multi-line text input
*
*  Implementation of TextArea using Controls 1.0
*/
Rectangle
{
    id: item

    property string placeholderText: ''
    property int    padding:         Ui.style.textAreaPadding

    property alias activeFocusOnPress:           edit.activeFocusOnPress
    property alias baseUrl:                      edit.baseUrl
    property alias canPaste:                     edit.canPaste
    property alias canRedo:                      edit.canRedo
    property alias canUndo:                      edit.canUndo
    property alias color:                        edit.color
    property alias contentHeight:                edit.contentHeight
    property alias contentWidth:                 edit.contentWidth
    property alias cursorDelegate:               edit.cursorDelegate
    property alias cursorPosition:               edit.cursorPosition
    property alias cursorRectangle:              edit.cursorRectangle
    property alias cursorVisible:                edit.cursorVisible
    property alias effectiveHorizontalAlignment: edit.effectiveHorizontalAlignment
    property alias font:                         edit.font
    property alias horizontalAlignment:          edit.horizontalAlignment
    property alias inputMethodComposing:         edit.inputMethodComposing
    property alias inputMethodHints:             edit.inputMethodHints
    property alias length:                       edit.length
    property alias lineCount:                    edit.lineCount
    property alias mouseSelectionMode:           edit.mouseSelectionMode
    property alias persistentSelection:          edit.persistentSelection
    property alias readOnly:                     edit.readOnly
    property alias renderType:                   edit.renderType
    property alias selectByMouse:                edit.selectByMouse
    property alias selectedText:                 edit.selectedText
    property alias selectedTextColor:            edit.selectedTextColor
    property alias selectionColor:               edit.selectionColor
    property alias selectionEnd:                 edit.selectionEnd
    property alias selectionStart:               edit.selectionStart
    property alias text:                         edit.text
    property alias textFormat:                   edit.textFormat
    property alias textMargin:                   edit.textMargin
    property alias verticalAlignment:            edit.verticalAlignment
    property alias wrapMode:                     edit.wrapMode

    implicitWidth:  edit.implicitWidth  + 2 * edit.anchors.margins
    implicitHeight: edit.implicitHeight + 2 * edit.anchors.margins

    color: Ui.style.textAreaColor

    TextEdit
    {
        id: edit

        anchors.fill:    parent
        anchors.margins: item.padding

        Keys.onUpPressed:     item.Keys.onUpPressed(event);
        Keys.onDownPressed:   item.Keys.onDownPressed(event);
        Keys.onTabPressed:    item.Keys.onTabPressed(event);
        Keys.onEnterPressed:  item.Keys.onEnterPressed(event);
        Keys.onReturnPressed: item.Keys.onReturnPressed(event);
    }

    Label
    {
        id: placeholder

        anchors.fill:    parent
        anchors.margins: item.padding

        visible: edit.length == 0

        text:    item.placeholderText
        color:   Ui.style.disabledColor
    }

    DebugItem
    {
    }

    function clear()
    {
        item.text = '';
    }
}
