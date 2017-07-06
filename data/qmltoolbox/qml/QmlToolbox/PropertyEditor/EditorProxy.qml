
import QtQuick 2.0

import QmlToolbox.PropertyEditor 1.0


/**
*  EditorProxy
*
*  Editor item that chooses the right type automatically
*/
Editor
{
    id: item

    implicitWidth:  editor ? editor.implicitWidth  : 0
    implicitHeight: editor ? editor.implicitHeight : 0
    
    property Item editor: null

    onStatusChanged:
    {
        // Abort if status in invalid
        if (!status)
            return;

        // Abort if editor has already been created
        if (editor != null)
            return;

        // Destroy old editor
        // editor.destroy();

        var isNumber = status.type === 'int' || status.type === 'float';
        var isEnum = status.type === 'enum' || (status.type === 'string' && status.hasOwnProperty('choices'));
        var useSpinBox = status.hasOwnProperty('asSpinBox') && status.asSpinBox === true;

        // Choose editor
        var editorType = editorNone;
             if (isEnum)                     editorType = editorEnum;
        else if (status.type === 'string')   editorType = editorString;
        else if (status.type === 'filename') editorType = editorFilename;
        else if (status.type === 'bool')     editorType = editorBool;
        else if (isNumber && useSpinBox)     editorType = editorSpinbox;
        else if (isNumber)                   editorType = editorNumber;
        else if (status.type === 'color')    editorType = editorColor;
        else if (status.type === 'range')    editorType = editorRange;
        if (!editorType) return;

        // Create editor
        item.editor = editorType.createObject(item, {});
    }

    Component { id: editorString;   EditorString   { anchors.fill: parent; properties: item.properties; path: item.path; slot: item.slot; status: item.status } }
    Component { id: editorFilename; EditorFilename { anchors.fill: parent; properties: item.properties; path: item.path; slot: item.slot; status: item.status } }
    Component { id: editorBool;     EditorBool     { anchors.fill: parent; properties: item.properties; path: item.path; slot: item.slot; status: item.status } }
    Component { id: editorNumber;   EditorNumber   { anchors.fill: parent; properties: item.properties; path: item.path; slot: item.slot; status: item.status } }
    Component { id: editorSpinbox;  EditorSpinbox  { anchors.fill: parent; properties: item.properties; path: item.path; slot: item.slot; status: item.status } }
    Component { id: editorColor;    EditorColor    { anchors.fill: parent; properties: item.properties; path: item.path; slot: item.slot; status: item.status } }
    Component { id: editorEnum;     EditorEnum     { anchors.fill: parent; properties: item.properties; path: item.path; slot: item.slot; status: item.status } }
    Component { id: editorRange;    EditorRange    { anchors.fill: parent; properties: item.properties; path: item.path; slot: item.slot; status: item.status } }
    Component { id: editorNone;     Editor         { anchors.fill: parent; properties: item.properties; path: item.path; slot: item.slot; status: item.status } }
}
