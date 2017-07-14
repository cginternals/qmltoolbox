
import QtQuick 2.0


QtObject
{
    id: propertyInterface

    signal slotChanged(string path, string slot, var status)

    function getStageTypes()
    {
        return [ 'Stage1', 'Stage2', 'Stage3' ];
    }

    function getSlotTypes(path)
    {
        return [ 'string', 'int' ];
    }

    function createStage(path, stage, type)
    {
        return '';
    }

    function removeStage(path, stage)
    {
    }

    function createSlot(path, slot, slotType, type)
    {
    }

    function getConnections(path)
    {
        return [
            { from: 'root.Text',   to: 'root.Stage1.Text' },
            { from: 'root.Number', to: 'root.Stage1.Number' },
            { from: 'root.Color' , to: 'root.Stage1.Color' },
            { from: 'root.Number', to: 'root.Stage2.Number' },
            { from: 'root.Stage1.Ok', to: 'root.Stage3.Ok1' },
            { from: 'root.Stage2.Ok', to: 'root.Stage3.Ok2' },
            { from: 'root.Stage3.Ok', to: 'root.Ok' }
        ];
    }

    function createConnection(sourcePath, sourceSlot, destPath, destSlot)
    {
    }

    function removeConnection(path, slot)
    {
    }

    function getStage(path)
    {
        var obj = {
            name: propertyInterface.stage.name
          , inputs: []
          , outputs: []
          , stages: []
        };

        var stage = null;
        if (path == 'root')        stage = propertyInterface.stage;
        if (path == 'root.Stage1') stage = propertyInterface.stage1;
        if (path == 'root.Stage2') stage = propertyInterface.stage2;
        if (path == 'root.Stage3') stage = propertyInterface.stage3;

        if (!stage) {
            return obj;
        }

        for (var i=0; i<stage.inputs.length; i++)
        {
            obj.inputs.push(stage.inputs[i].name);
        }

        for (var i=0; i<stage.outputs.length; i++)
        {
            obj.outputs.push(stage.outputs[i].name);
        }

        for (var i=0; i<stage.stages.length; i++)
        {
            obj.stages.push(stage.stages[i]);
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

        if (path == 'root' && slot == 'Boolean')
        {
            if (value) timer.start();
            else       timer.stop();
        }

        if (path == 'root' && slot == 'Mode')
        {
            var inputs = stage.inputs;

            inputs[2].value = value;

            stage.inputs = inputs;

            propertyInterface.slotChanged('root', 'Text' , inputs[2]);
        }

        if (path == 'root' && slot == 'Style')
        {
            var inputs = stage.inputs;

            var mapping = {'red': '#FF0000', 'yellow': '#FFFF00', 'green' : '#00FF00'};

            inputs[6].value = mapping[value];

            stage.inputs = inputs;

            propertyInterface.slotChanged('root', 'Color' , inputs[6]);
        }

        if (path == 'root' && slot == 'Number')
        {
            var inputs = stage.inputs;

            var val = Math.floor(value);

            var red = Math.floor(value * 2.55);
            var color = red.toString(16);
            while (color.length < 2) color = '0' + color;
            color = '#0000' + color;

            var text = '' + val;

            var choices = [ 'Zero', 'One', 'Two', 'Three', 'Four' ];
            if (val >= 50) choices = [ '50', '60', '70', '80', '90' ]

            var mode = 'Zero';
            if (val >= 10) mode = 'One';
            if (val >= 20) mode = 'Two';
            if (val >= 30) mode = 'Three';
            if (val >= 40) mode = 'Four';
            if (val >= 50) mode = '50';
            if (val >= 60) mode = '60';
            if (val >= 70) mode = '70';
            if (val >= 80) mode = '80';
            if (val >= 90) mode = '90';

            inputs[0].choices = choices;
            inputs[0].value   = mode;
            inputs[2].value   = text;
            inputs[3].value   = val;
            inputs[6].value   = color;
            inputs[7].value   = text;

            stage.inputs = inputs;

            propertyInterface.slotChanged('root', 'Mode',   inputs[0]);
            propertyInterface.slotChanged('root', 'Text',   inputs[2]);
            propertyInterface.slotChanged('root', 'Number', inputs[3]);
            propertyInterface.slotChanged('root', 'Color' , inputs[6]);
            propertyInterface.slotChanged('root', 'Filename', inputs[7]);
        }

        if (path == 'root' && slot == 'Number2')
        {
            var inputs = stage.inputs;

            var text = '' + value;

            inputs[2].value = text;

            stage.inputs = inputs;

            propertyInterface.slotChanged('root', 'Text', inputs[2]);
        }
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

    // Data

    property QtObject stage: QtObject
    {
        property string name: 'DemoStage'

        property var inputs: [
            {
                name: 'Mode',
                type: 'string',
                choices: [ 'Zero', 'One', 'Two', 'Three', 'Four' ],
                value: 'One'
            },

            {
                name: 'Style',
                type: 'string',
                choices: [ 'yellow', 'red', 'green' ],
                pixmaps: [
                    'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFAAAAAUCAIAAACVui2AAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAiElEQVRYhe2Pyw0DQQhD12YrS60pJG0NGkMOsx+t0gHhHZCx4PDw/rwAIww0wgDjHfbnauuSNGC/Xq7+WLeNmchgJjMYyTPf5XMigz/36xhSuDQUPsMVQ3LFuPKMoXDFmPIVFD51lvfvalzc/owWrk4LV6eFq9PC1Wnh6rRwdVq4Oi1cnRauzhckb4MeLdt9QAAAAABJRU5ErkJggg==',
                    'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFAAAAAUCAIAAACVui2AAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAQklEQVRYhe3PsQ0AIAzEQGD/RTNEXrS0VEjG10XKF55V1d05XJ23/2/nSdb4jMF0BtMZTGcwncF0BtMZTGcwncF0GwrH7dwizJCHAAAAAElFTkSuQmCC',
                    'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFAAAAAUCAIAAACVui2AAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAaUlEQVRYhe2PywnAMAxDLZMs1lk7SOeKoeklPwqFnFU9TJAgCB7O6wCSt8tf2ZFa9SXjnXtdsuc+koCZ7bYapUbUEi2Mt8SotvFnZ6evhdvPkDA7EmZHwuxImB0JsyNhdiTMjoTZkTA7Dw+7dR47RyiWAAAAAElFTkSuQmCC'
                ],
                value: 'yellow'
            },

            {
                name: 'Text',
                type: 'string',
                value: ''
            },

            {
                name: 'Number',
                type: 'int',
                minimumValue: 0,
                maximumValue: 100,
                value: 20,
                updateOnDrag: true
            },

            {
                name: 'Number2',
                type: 'float',
                minimumValue: 0.0,
                maximumValue: 5.0,
                decimals: 2,
                value: 1.0,
                asSpinBox: true,
                stepSize: 0.1
            },

            {
                name: 'Boolean',
                type: 'bool',
                value: false
            },

            {
                name: 'Color',
                type: 'color',
                value: '#0000ff'
            },

            {
                name: 'Filename',
                type: 'filename',
                value: 'test.txt'
            }
        ]

        property var outputs: [
            {
                name: 'Ok',
                type: 'bool',
                value: true
            }
        ]

        property var stages: [
            'Stage1', 'Stage2', 'Stage3'
        ]
    }

    property QtObject stage1: QtObject
    {
        property string name: 'Stage1'

        property var inputs: [
            {
                name: 'Text',
                type: 'string',
                value: ''
            },

            {
                name: 'Number',
                type: 'int',
                minimumValue: 0,
                maximumValue: 100,
                value: 0
            },

            {
                name: 'Color',
                type: 'color',
                value: '#00ff00'
            },
        ]

        property var outputs: [
            {
                name: 'Ok',
                type: 'bool',
                value: true
            }
        ]

        property var stages: [
        ]
    }

    property QtObject stage2: QtObject
    {
        property string name: 'Stage2'

        property var inputs: [
            {
                name: 'Number',
                type: 'int',
                value: 0
            }
        ]

        property var outputs: [
            {
                name: 'Ok',
                type: 'bool',
                value: true
            }
        ]

        property var stages: [
        ]
    }

    property QtObject stage3: QtObject
    {
        property string name: 'Stage3'

        property var inputs: [
            {
                name: 'Ok1',
                type: 'bool',
                value: true
            },

            {
                name: 'Ok2',
                type: 'bool',
                value: true
            }
        ]

        property var outputs: [
            {
                name: 'Ok',
                type: 'bool',
                value: true
            }
        ]

        property var stages: [
        ]
    }

    property QtObject timerObject: Timer
    {
        id: timer

        interval: 100
        repeat:   true

        triggeredOnStart: false

        onTriggered:
        {
            var inputs = stage.inputs;

            var value = (inputs[3].value + 1) % 100;
            propertyInterface.setValue('root', 'Number', value);
        }
    }
}
