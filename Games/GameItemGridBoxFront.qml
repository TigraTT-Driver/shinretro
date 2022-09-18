import QtQuick 2.15
import QtGraphicalEffects 1.12
import QtMultimedia 5.15
import "../Global"

Item {
    id: root

    property string clearedShortname: clearShortname(currentCollection.shortName)
    readonly property string collectionColor: {
        if (dataConsoles[clearedShortname] !== undefined) {
            return dataConsoles[clearedShortname].color
        } else {
            return dataConsoles["default"].color
        }
    }
    readonly property string collectionAltColor: {
        if (dataConsoles[clearedShortname] !== undefined) {
            return accentColorNr !== 0 ? dataConsoles[clearedShortname].altColor : dataConsoles[clearedShortname].altColor2
        } else {
            return accentColorNr !== 0 ? dataConsoles["default"].altColor : dataConsoles["default"].altColor2
        }
    }
    readonly property string selectionFrameColorSelected:{
        if (selectionFrame === 1) {
            return colorScheme[theme].selected
         } else {
            return collectionAltColor
        }
    }
    readonly property string selectionFrameColorTransition:{
        if (selectionFrame === 1) {
            return colorScheme[theme].selectedtransition
         } else {
            return collectionColor
        }
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
                parentImageHeight: boxFront.paintedHeight
            }

            CompletedIcon {
                id: completedicon
                parentImageWidth: boxFront.paintedWidth
            }
        }

        Rectangle {
            anchors.centerIn: boxFront
            anchors.horizontalCenterOffset: vpx(- (1 - (1 / gamesGridIPR)))
            width: boxFront.paintedWidth + vpx(8)
            height: boxFront.paintedHeight + vpx(8)
            color: selectionFrameColorSelected
            opacity: isCurrentItem
            Behavior on opacity {
                NumberAnimation { duration: 200; }
            }

            // Animation layer
            Rectangle {
                id: rectAnim
                width: parent.width
                height: parent.height
                visible: isCurrentItem
                color: selectionFrameColorTransition

                SequentialAnimation on opacity {
                    id: colorAnim
                    running: true
                    loops: Animation.Infinite
                    NumberAnimation {
                        to: 1
                        duration: 200
                    }
                    NumberAnimation {
                        to: 0
                        duration: 500
                    }
                    PauseAnimation { duration: 200 }
                }
            }
            z:-10
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

    function steamAppID (gameData) {
        var str = gameData.assets.boxFront.split("header");
        return str[0];
    }

    function steamBoxFront(gameData) {
        return steamAppID(gameData) + "/library_600x900_2x.jpg";
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