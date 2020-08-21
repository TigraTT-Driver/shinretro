import QtQuick 2.8
import QtGraphicalEffects 1.12

Item {
    id: cpnt_gameList_game

    Item {
        anchors.fill: parent

        Image {
            id: img_game_screenshot
            source: model.assets.screenshot || model.assets.background
            anchors.fill: parent
            asynchronous: true
            fillMode: Image.PreserveAspectCrop
        }

        // Desaturate {
        //     anchors.fill: img_game_screenshot
        //     source: img_game_screenshot
        //     desaturation: doubleFocus ? 0 : 1
        //     Behavior on desaturation {
        //         NumberAnimation { duration: 200; }
        //     }
        // }

        // Rectangle {
        //     anchors.fill: parent
        //     color: "#80000000"
        //     opacity: doubleFocus
        //     Behavior on opacity {
        //         NumberAnimation { duration: 200; }
        //     }
        // }

        Image {
            id: img_game_logo
            source: model.assets.logo
            anchors {
                fill: parent
                margins: parent.width * 0.15
            }
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Text {
            anchors.fill: parent
            text: model.title
            font {
                family: global.fonts.sans
                weight: Font.Medium
                pixelSize: vpx(16)
            }
            color: "white"

            horizontalAlignment : Text.AlignHCenter
            verticalAlignment : Text.AlignVCenter
            wrapMode: Text.Wrap

            visible: model.assets.logo === ""
            
        }

        Rectangle {
            anchors.fill: parent
            color: "black"
            opacity: doubleFocus ? 0.8 : 0
            Behavior on opacity {
                NumberAnimation { duration: 200; }
            }
        }

        // Rectangle {
        //     width: vpx(25)
        //     height: vpx(25)
        //     color: doubleFocus ? "#00991E" : "#191919"
        //     anchors {
        //         top: parent.top
        //         left: parent.left
        //     }

        //     Image {
        //         id: img_heart
        //         width: vpx(12)
        //         height: vpx(12)
        //         sourceSize.width: width
        //         sourceSize.height: height
        //         anchors {
        //             bottom: parent.bottom; bottomMargin: vpx(5)
        //             right: parent.right; rightMargin: vpx(5)
        //         }
        //         source: "../assets/heart.png"
        //         fillMode: Image.PreserveAspectFit
        //     }

        //     visible: (root.state !== "home" && model.favorite)
        // }

        Rectangle {
            width: parent.height * 0.2
            height: width
            anchors.centerIn: parent
            radius: width

            color: "#00991E"
            Text {
                anchors.centerIn: parent
                text: "A"
                font {
                    family: global.fonts.sans
                    weight: Font.Bold
                    pixelSize: parent.height * 0.75
                }
                color: "white"
            }
            visible: doubleFocus
        }

        Rectangle {
            anchors.fill: parent
            color: "transparent"
            border {
                width: vpx(5)
                color: "#ED3496"
            }
            visible: model.favorite && root.state === "games"
        }

        // Image {
        //     width: parent.width * 0.6
        //     sourceSize.width: width
        //     anchors.centerIn: parent
        //     source: "../assets/controls/button_A_reverse"
        //     fillMode: Image.PreserveAspectFit
        //     visible: doubleFocus
        // }
        
    }

}