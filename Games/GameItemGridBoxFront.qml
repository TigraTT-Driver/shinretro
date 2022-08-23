import QtQuick 2.15
import QtGraphicalEffects 1.12
import QtMultimedia 5.15
import "../Global"

Item {
    id: root

    readonly property var collectionAltColor:{
        if (accentColorNr != 0) {
            dataConsoles[clearShortname(currentCollection.shortName)].altColor
        } else {
            dataConsoles[clearShortname(currentCollection.shortName)].altColor2
        }
    }

    function steamAppID (gameData) {
        var str = gameData.assets.boxFront.split("header");
        return str[0];
    }

    function steamBoxFront(gameData) {
        return steamAppID(gameData) + "/library_600x900_2x.jpg"
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

    signal activated
    signal highlighted
    signal unhighlighted

    property bool selected
    property var gameData: modelData

    Item  {
        id: container
        anchors.fill: parent
        Behavior on opacity { NumberAnimation { duration: 200 } }

        Image {
            id: boxFront

            anchors.fill: parent
            anchors.margins: vpx(3)
            source: boxArt(gameData)
            // For Steam games that lack portrait mode art
            onStatusChanged: {
                if (status == Image.Error) {
                    boxFront.source = gameData.assets.boxFront;
                }
            }
            fillMode: Image.PreserveAspectFit
            horizontalAlignment: Image.AlignHCenter
            sourceSize: Qt.size(boxFront.width, boxFront.height)
            smooth: true
            asynchronous: true
            scale: selected ? 1.1 : 1
            Behavior on opacity { NumberAnimation { duration: 200 } }

            FavoriteIcon {
                id: faveicon
                parentImageWidth: boxFront.paintedWidth
            }
            Rectangle {
                anchors.centerIn: boxFront
                anchors.horizontalCenterOffset: vpx(-(1 - (1/gamesGridIPR)))
                anchors.verticalCenterOffset: vpx(-0.75)
                width: boxFront.paintedWidth + vpx(12)
                height: boxFront.paintedHeight + vpx(12)
                color: "transparent"
                border {
                    width: vpx(4)
                    color: collectionAltColor
                }
                opacity: isCurrentItem
                Behavior on opacity {
                    NumberAnimation { duration: 200; }
                }
            }
        }
    }

    // List specific input
    Keys.onPressed: {
        // Accept
        if (api.keys.isAccept(event) && !event.isAutoRepeat) {
            event.accepted = true;
            activated();
        }
    }

    Text {
        anchors.fill: parent
        text: model.title
        font {
            family: global.fonts.sans
            weight: Font.Medium
            pixelSize: vpx(16 * fontScalingFactor)
        }
        color: colorScheme[theme].text

        horizontalAlignment : Text.AlignHCenter
        verticalAlignment : Text.AlignVCenter
        wrapMode: Text.Wrap

        visible: boxArt(gameData) === ""
    }

}