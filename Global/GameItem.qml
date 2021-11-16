import QtQuick 2.15
import QtGraphicalEffects 1.12
import QtMultimedia 5.15

Item {
    id: root

    readonly property var collectionAltColor: dataConsoles[clearShortname(currentCollection.shortName)].altColor
    // NOTE: This is technically duplicated from utils.js but importing that file into every delegate causes crashes
    function steamAppID (gameData) {
        var str = gameData.assets.boxFront.split("header");
        return str[0];
    }

    function steamBoxFront(gameData) {
        return steamAppID(gameData) + "/library_600x900_2x.jpg"
    }


    function logo(data) {
       if (data != null) {
            if (data.assets.boxFront.includes("header.jpg")) 
                return steamBoxFront(data);
        else {
            if (data.assets.boxFront != "")
                return data.assets.boxFront;
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
    property bool playVideo: gameData ? gameData.assets.videoList.length : ""
    scale: selected ? 1 : 0.95
    Behavior on scale { NumberAnimation { duration: 100 } }
    z: selected ? 10 : 1

    onSelectedChanged: {
        if (selected && playVideo)
            fadescreenshot.restart();
        else {
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

    Item  {
        id: container

        anchors.fill: parent
        Behavior on opacity { NumberAnimation { duration: 200 } }
        Image {
            id: boxFront

            anchors.fill: parent
            anchors.margins: vpx(3)
            property var boxFrontImage: (gameData && gameData.collections.get(0).shortName === "retropie") ? gameData.assets.boxFront : (gameData.collections.get(0).shortName === "steam") ? logo(gameData) : gameData.assets.boxFront
            source: modelData ? boxFrontImage || "" : ""
            fillMode: Image.PreserveAspectFit
            sourceSize: Qt.size(boxFront.width, boxFront.height)
            smooth: true
            asynchronous: true
            scale: selected ? 1.1 : 1
            Behavior on opacity { NumberAnimation { duration: 200 } }
            Rectangle {
                anchors.centerIn: boxFront
                width: boxFront.paintedWidth + vpx(15)
                height: boxFront.paintedHeight + vpx(15)
                color: "transparent"
                border {
                    width: vpx(8)
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
            pixelSize: vpx(16)
        }
        color: "white"

        horizontalAlignment : Text.AlignHCenter
        verticalAlignment : Text.AlignVCenter
        wrapMode: Text.Wrap

        visible: model.assets.boxFront === ""
        
    }
}