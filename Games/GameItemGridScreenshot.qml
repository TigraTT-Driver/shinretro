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
            return accentColorNr != 0 ? dataConsoles[clearedShortname].altColor : dataConsoles[clearedShortname].altColor2
        } else {
            return accentColorNr != 0 ? dataConsoles["default"].altColor : dataConsoles["default"].altColor2
        }
    }
    readonly property string selectionFrameColorSelected:{
        if (selectionFrame == "1") {
            return colorScheme[theme].selected
         } else {
            return collectionAltColor
        }
    }
    readonly property string selectionFrameColorTransition:{
        if (selectionFrame == "1") {
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

    // In order to use the retropie icons here we need to do a little collection specific hack
    readonly property bool playVideo: gameData ? gameData.assets.videoList.length : ""
    scale: isCurrentItem ? 1 : 0.95
    Behavior on scale { NumberAnimation { duration: 100 } }
    z: isCurrentItem ? 10 : 1

    onSelectedChanged: {
        if (isCurrentItem && playVideo) {
            fadescreenshot.restart();
        } else {
            fadescreenshot.stop();
            screenshot.opacity = 1;
            container.opacity = 1;
        }
    }

    // NOTE: Fade out the bg so there is a smooth transition into the video
    Timer {
        id: fadescreenshot
        interval: 1200
        onTriggered: {
            screenshot.opacity = 0;
        }
    }

    Item {
        id: container
        anchors.fill: parent
        Behavior on opacity { NumberAnimation { duration: 200 } }

        Image {
            id: marquee
            anchors.fill: parent
            source: gameData ? gameData.assets.marquee : ""
            fillMode: Image.PreserveAspectFit
            sourceSize: Qt.size(screenshot.width, screenshot.height)
            smooth: false
            asynchronous: true
            visible: gameData.assets.marquee && !doubleFocus
            Behavior on opacity { NumberAnimation { duration: 200 } }
        }

        DropShadow {
            anchors.fill: parent
            horizontalOffset: 0
            verticalOffset: 5
            radius: 20
            samples: 20
            color: "#000000"
            source: marquee
            opacity: visible ? 0.5 : 0
            visible: gameData.assets.marquee && !doubleFocus
            Behavior on opacity { NumberAnimation {duration: 200 } }
            z: -5
        }

        Image {
            id: screenshot
            anchors.fill: parent
            anchors.margins: vpx(3)
            source: gameData ? gameData.assets.screenshots[0] || gameData.assets.titlescreen || gameData.assets.background || "" : ""
            fillMode: Image.PreserveAspectCrop
            sourceSize: Qt.size(screenshot.width, screenshot.height)
            smooth: false
            asynchronous: true
            visible: !gameData.assets.marquee || doubleFocus
            Behavior on opacity { NumberAnimation { duration: 200 } }

            Image {
                id: favelogo
                anchors.fill: parent
                anchors.centerIn: parent
                anchors.margins: root.width / 10
                property string logoImage: (gameData && gameData.collections.get(0).shortName === "retropie") ? gameData.assets.boxFront : (gameData.collections.get(0).shortName === "steam") ? logo(gameData) : gameData.assets.logo
                source: gameData ? logoImage || "" : ""
                sourceSize: Qt.size(favelogo.width, favelogo.height)
                fillMode: Image.PreserveAspectFit
                asynchronous: true
                smooth: true
                visible: !gameData.assets.marquee || doubleFocus
                z: 10
            }

            Text {
                id: titletext
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
                visible: model.assets.logo === ""
            }

            FavoriteIcon {
                id: faveicon
                parentImageWidth: screenshot.width
            }

            CompletedIcon {
                id: completedicon
                parentImageWidth: screenshot.width
                z: 15
            }
        }
    }

    GameVideo {
        game: gameData
        anchors.fill: parent
        playing: isCurrentItem && gamesVideo != "1"
        sound: gamesVideoMute
    }

    Rectangle {
        id: regborder
        anchors.fill: parent
        color: "transparent"
        anchors.rightMargin: 1
        anchors.leftMargin: 1
        anchors.bottomMargin: 1
        anchors.topMargin: 1
        border.width: vpx(3)
        border.color: colorScheme[theme].secondary
        opacity: 0.5
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: vpx(-3)
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

    function steamAppID (gameData) {
        var str = gameData.assets.boxFront.split("header");
        return str[0];
    }

    function steamLogo(gameData) {
        return steamAppID(gameData) + "/logo.png";
    }

    function logo(data) {
        if (data != null) {
            if (data.assets.boxFront.includes("header.jpg")) {
                return steamLogo(data);
            } else if (data.assets.logo != "") {
                return data.assets.logo;
            }
        }
        return "";
    }

}
