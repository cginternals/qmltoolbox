
import QtQuick 2.0


QtObject
{
    id: propertyInterface

    property QtObject stage: QtObject
    {
        id: stage

        property string name: 'DemoStage'

        property var inputs: [
            {
                category: 'General Settings',
                name: 'Mode',
                type: 'string',
                choices: [ 'One', 'Two', 'Three' ],
                advanced: false,
                value: 'One'
            },

            {
                category: 'General Settings',
                name: 'Text',
                type: 'string',
                advanced: false,
                value: ''
            },

            {
                category: 'General Settings',
                name: 'Number',
                type: 'int',
                minimumValue: 0,
                maximumValue: 100,
                advanced: false,
                value: 20
            },

            {
                category: 'General Settings',
                name: 'Boolean',
                type: 'bool',
                advanced: false,
                value: false
            },

            {
                category: 'General Settings',
                name: 'Color',
                type: 'color',
                advanced: false,
                value: '#0000ff'
            },

            {
                category: 'General Settings',
                name: 'Filename',
                type: 'filename',
                advanced: false,
                value: 'test.txt'
            }
        ]

        property var outputs: [
        ]
    }

    function getStage(path)
    {
        var obj = {
            name: propertyInterface.stage.name
          , inputs: []
          , outputs: []
        };

        for (var i=0; i<propertyInterface.stage.inputs.length; i++)
        {
            obj.inputs.push(propertyInterface.stage.inputs[i].name);
        }

        for (var i=0; i<propertyInterface.stage.outputs.length; i++)
        {
            obj.outputs.push(propertyInterface.stage.outputs[i].name);
        }

        return obj;
    }

    function getSlot(path, slot)
    {
        // Get slot
        var slotInfo = getSlotInfo(path, slot);
        return slotInfo;
    }

    function getValue(path, slot)
    {
        // Get slot
        var slotInfo = getSlotInfo(path, slot);
        return slotInfo.value;
    }

    function setValue(path, slot, value)
    {
        // Get slot
        var slotInfo = getSlotInfo(path, slot);
        slotInfo.value = value;
    }

    // Internals
    function getSlotInfo(path, slot)
    {
        for (var i=0; i<propertyInterface.stage.inputs.length; i++)
        {
            if (propertyInterface.stage.inputs[i].name == slot)
            {
                return propertyInterface.stage.inputs[i];
            }
        }

        for (var i=0; i<propertyInterface.stage.outputs.length; i++)
        {
            if (propertyInterface.stage.outputs[i].name == slot)
            {
                return propertyInterface.stage.outputs[i];
            }
        }

        return null;
    }

    function printAll()
    {
        var obj = {};
        obj.name    = stage.name;
        obj.inputs  = stage.inputs;
        obj.outputs = stage.outputs;

        console.log(JSON.stringify(obj) + '\n');
    }
}

/*
QtObject
{
    id: propertyInterface

    property string name: "PipelineDummy"

    property QtObject stage: QtObject
    {
        id: stage

        property var inputs:
        [
            qsTr("Name of pony"),
            qsTr("Activate magic abilities"),
            qsTr("Length of pony"),
            qsTr("Color of pony"),
            qsTr("Name of its left toe")
        ]

        property var slots:
        [
            {
                name:    qsTr('Name of pony'),
                type:    'string',
                value:   'Erhardt',
                options: {}
            },

            {
                name:    qsTr('Activate magic abilities'),
                type:    'bool',
                value:   true,
                options: {}
            },

            {
                name:    qsTr('Length of pony'),
                type:    'float',
                value:   1.3,
                options: {}
            },

            {
                name:    qsTr('Color of pony'),
                type:    'color',
                value:   '#000000',
                options: {}
            },

            {
                name:    qsTr('Name of its left toe'),
                type:    'string',
                value:   'Kurt',
                options: {}
            },
        ]

        function getSlot(slotName)
        {
            for (var i = 0; i < stage.slots.length; i++)
            {
                var slot = stage.slots[i];

                if (slot.name == slotName)
                {
                    return slot;
                }
            }

            return {
                name: '',
                type: '',
                value: null,
                options: {}
            };
        }

        function setSlotValue(slotName, value)
        {
            var slot = getSlot(slotName);

            slot.value = value;
        }
    }

    function getStage(path)
    {
        return propertyInterface.stage;
    }

    function getSlot(path)
    {
        var stage = propertyInterface.stage;
        var names = path.split('.');
        var slotName = names[names.length - 1];

        return stage.getSlot(slotName);
    }

    function setSlotValue(path, value)
    {
        var stage = propertyInterface.stage;
        var names = path.split('.');
        var slotName = names[names.length - 1];

        stage.setSlotValue(slotName, value);
    }
}
*/
