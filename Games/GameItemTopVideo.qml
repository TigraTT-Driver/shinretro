import QtQuick 2.15
import QtGraphicalEffects 1.12
import SortFilterProxyModel 0.2
import QtMultimedia 5.15
import "../Global"

Item {
    id: item_game_screenshot
    width: parent.width
    height: parent.height * 0.9
    anchors.verticalCenter: parent.verticalCenter

    Component {
        id: cpnt_game_screenshot

        Item {
            anchors.fill: parent

            Rectangle {
                id: rect_screenshot
                width: img_game_screenshot.paintedWidth + vpx(15)
                height: img_game_screenshot.paintedHeight + vpx(15)
                anchors.centerIn: img_game_screenshot
                color: colorScheme[theme].secondary
            }

            DropShadow {
                anchors.fill: rect_screenshot
                horizontalOffset: 0
                verticalOffset: vpx(5)
                radius: 24
                samples: 22
                spread: 0.2
                color: "#35000000"
                source: rect_screenshot
            }

            Image {
                id: img_game_screenshot
                source: currentGame.assets.screenshots[0] || currentGame.assets.titlescreen
                anchors {
                    fill: parent
                }
                fillMode: Image.PreserveAspectFit
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                asynchronous: true

                Behavior on source {
                    PropertyAnimation {
                        target: img_game_screenshot
                        property: "opacity"
                        from: 0
                        to: 1
                        duration: 600
                        easing.type: Easing.OutExpo
                    }
                }
            }

            GameVideo {
                game: currentGame
                width: img_game_screenshot.paintedWidth
                height: img_game_screenshot.paintedHeight
                anchors.centerIn: img_game_screenshot
                playing: gamesVideo !== 1
                sound: gamesVideoMute
            }
        }
    }

    Loader {
        id: loader_game_screenshot
        anchors.fill: parent
        asynchronous: true
        sourceComponent: cpnt_game_screenshot
        active: games.focus && currentGame !== null
        visible: status === Loader.Ready
    }

}