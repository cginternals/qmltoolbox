
import QtQuick 2.4


/**
*  Editor
*
*  Base for property editor items
*/
Item 
{
    id: item

    property var    properties: null ///< Interface for communicating with the actual properties
    property string path:       ''   ///< Path to stage (e.g., 'root.Stage1')
    property string slot:       ''   ///< Name of slot (e.g., 'Input1')
    property var    status:     {}   ///< Status of the slot (see PropertyEditor documentation)

    function update()
    {
        // status = item.properties.getSlot(path, slot);
    }
}
