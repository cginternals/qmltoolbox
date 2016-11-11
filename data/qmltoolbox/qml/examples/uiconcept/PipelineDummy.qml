
import QtQuick 2.7

QtObject {
    id: pipeline

    property string name: "PipelineDummy"
    property QtObject stage: QtObject {
        id: stage

        property var inputs: [
            "Name of pony",
            "Activate magic abilities",
            "Length of pony",
            "Color of pony",
            "Name of its left toe"
        ]

        property var slots: [
            {
                name:    'Name of pony',
                type:    'string',
                value:   'Erhardt',
                options: {}
            },
            {
                name:    'Activate magic abilities',
                type:    'bool',
                value:   true,
                options: {}
            },
            {
                name:    'Length of pony',
                type:    'float',
                value:   1.3,
                options: {}
            },
            {
                name:    'Color of pony',
                type:    'color',
                value:   '#000000',
                options: {}
            },
            {
                name:    'Name of its left toe',
                type:    'string',
                value:   'Kurt',
                options: {}
            },
        ]

        function getSlot(slotName) {
            for (var i = 0; i < stage.slots.length; i++) {
                var slot = stage.slots[i];
                if (slot.name == slotName) {
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

        function setSlotValue(slotName, value) {
            var slot = getSlot(slotName);

            slot.value = value;
        }
    }

    function getStage(path) {
        return pipeline.stage;
    }

    function getSlot(path) {
        var stage = pipeline.stage;

        var names = path.split('.');
        var slotName = names[names.length - 1];
        return stage.getSlot(slotName);
    }

    function setSlotValue(path, value) {
        var stage = pipeline.stage;

        // Set value
        var names = path.split('.');
        var slotName = names[names.length - 1];

        stage.setSlotValue(slotName, value);
    }
}