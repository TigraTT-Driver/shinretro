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

    function steamLogo(gameData) {
        return steamAppID(gameData) + "/logo.png"
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
            scale: isCurrentItem ? 1.1 : 1
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
            scale: selected ? 1.1 : 1
        }

        Image {
            id: favelogo
            anchors.fill: parent
            anchors.centerIn: parent
            anchors.margins: root.width/10
            property var logoImage: (gameData && gameData.collections.get(0).shortName === "retropie") ? gameData.assets.boxFront : (gameData.collections.get(0).shortName === "steam") ? logo(gameData) : gameData.assets.logo
            source: gameData ? logoImage || "" : ""
            sourceSize: Qt.size(favelogo.width, favelogo.height)
            fillMode: Image.PreserveAspectFit
            asynchronous: true
            smooth: true
            scale: isCurrentItem ? 1.1 : 1
            visible: !gameData.assets.marquee || doubleFocus
            Behavior on scale { NumberAnimation { duration: 100 } }
            z: 10
        }

        Text {
            id: titletext
            anchors.fill: parent
            text: model.title
            font {
                family: global.fonts.sans
                weight: Font.Medium
                pixelSize: vpx(16  * fontScalingFactor)
            }
            color: colorScheme[theme].text
            horizontalAlignment : Text.AlignHCenter
            verticalAlignment : Text.AlignVCenter
            wrapMode: Text.Wrap
            visible: model.assets.logo === ""
        }
    }

    GameVideo {
        game: gameData
        anchors.fill: parent
        playing: isCurrentItem && gamesVideo != "1"
        sound: gamesVideoMute
    }

    Rectangle {
        id: favicon
        anchors { 
            right: parent.right; rightMargin: (parent.width - screenshot.width)/2 + vpx(3);
            top: parent.top; topMargin: (parent.height - screenshot.height)/2 + vpx(3) 
        }
        width: vpx(40)
        height: width
        color: colorScheme[theme].favorite.replace(/#/g, "#77");
        visible: gameData.favorite
        Text {
            text: glyphs.favorite
            anchors.fill: parent
            anchors.margins: vpx(8)  
            font {
                family: glyphs.name;
                pixelSize: vpx(22)
            }
            color: colorScheme[theme].favorite
        }      
        transform: Matrix4x4 {
            property real a: 12 * Math.PI / 180
            matrix: Qt.matrix4x4(
                1,      -Math.tan(a),       0,      0,
                0,      1,                  0,      0,
                0,      0,                  1,      0,
                0,      0,                  0,      1
            )
        }
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
        width: screenshot.width + vpx(8)
        height: screenshot.height + vpx(8)
        color: "transparent"
        border {
            width: vpx(5)
            color: collectionAltColor
        }
        opacity: isCurrentItem
        Behavior on opacity {
            NumberAnimation { duration: 200; }
        }
    }

}
