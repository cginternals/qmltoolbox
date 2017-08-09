import QtQuick 2.0

//this control can be used to showcase all possible permutations of generative thumbs
Item {
    property var colorSchemes: [
        ["#FF00FE", "#23DAE0"],
        ["#1E1848", "#EA601F"],
        ["#2C2E83", "#90F18C"],
        ["#702E9D", "#FDBE58"],
        ["#2C2E83", "#90F18C"],
        ["#49BEB7", "#FC345C"],
    ]

    Flow {
        Repeater {
            model: ListModel {

                Component.onCompleted: {

                    for(var i = 0; i < colorSchemes.length; i++) {

                        this.append( {
                                         type: i,
                                         color1: colorSchemes[i][0],
                                         color2: colorSchemes[i][1],
                                     } )
                    }
                }
            }

            delegate: GenerativeThumb {
                svgIndex: type
                strokeColor: color1
                fill1: color2
            }
        }
    }
}
