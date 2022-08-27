import QtQuick 2.15
import QtGraphicalEffects 1.12
import SortFilterProxyModel 0.2
import QtMultimedia 5.15
import "../Global"

Item {
    id: item_game_boxArt
    width: parent.width
    height: parent.height * 0.9
    anchors.verticalCenter: parent.verticalCenter

    Component {
        id: cpnt_game_boxArt

        Item {
            anchors.fill: parent

            Rectangle {
                id: rect_boxArt
                width: img_game_boxArt.paintedWidth + vpx(15)
                height: img_game_boxArt.paintedHeight + vpx(15)
                anchors.centerIn: img_game_boxArt
                color: colorScheme[theme].secondary
            }

            DropShadow {
                anchors.fill: rect_boxArt
                horizontalOffset: 0
                verticalOffset: vpx(5)
                radius: 24
                samples: 22
                spread: 0.2
                color: "#35000000"
                source: rect_boxArt
            }

            Image {
                id: img_game_boxArt
                source: boxArt(currentGame)
                anchors {
                    fill: parent
                }
                fillMode: Image.PreserveAspectFit
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                asynchronous: true

                Behavior on source {
                    PropertyAnimation {
                        target: img_game_boxArt
                        property: "opacity"
                        from: 0
                        to: 1
                        duration: 600
                        easing.type: Easing.OutExpo
                    }
                }
            }
        }
    }

    Loader {
        id: loader_game_boxArt
        anchors.fill: parent
        asynchronous: true
        sourceComponent: cpnt_game_boxArt
        active: games.focus && currentGame !== null
        visible: status === Loader.Ready
    }

    function steamAppID (currentGame) {
        var str = currentGame.assets.boxFront.split("header");
        return str[0];
    }

    function steamBoxFront(currentGame) {
        return steamAppID(currentGame) + "/library_600x900_2x.jpg"
    }

    function boxArt(data) {
        if (data != null) {
            if (data.assets.boxFront.includes("header.jpg")) 
                return steamBoxFront(data);
            else {
                if (data.assets.boxFront != "")
                    return data.assets.boxFront;
                else if (data.assets.poster != "")
                    return data.assets.poster;
                else if (data.assets.banner != "")
                    return data.assets.banner;
                else if (data.assets.tile != "")
                    return data.assets.tile;
                else if (data.assets.cartridge != "")
                    return data.assets.cartridge;
                else if (data.assets.logo != "")
                    return data.assets.logo;
            }
        }
        return "";
    }

}