import QtQuick 2.15
import QtGraphicalEffects 1.12
import QtMultimedia 5.15

Item {
    id: root

    readonly property var collectionAltColor:  dataConsoles[clearShortname(currentCollection.shortName)].altColor

    // NOTE: This is technically duplicated from utils.js but importing that file into every delegate causes crashes
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
            fillMode: Image.PreserveAspectFit
            sourceSize: Qt.size(boxFront.width, boxFront.height)
            smooth: true
            asynchronous: true
            scale: selected ? 1.1 : 1
            Behavior on opacity { NumberAnimation { duration: 200 } }
            Rectangle {
                id: favicon
                anchors { 
                    right: parent.right; rightMargin: (parent.width - boxFront.paintedWidth)/2 + vpx(3);
                    top: parent.top; topMargin: (parent.height - boxFront.paintedHeight)/2 + vpx(3) 
                }
                width: vpx(40)
                height: width
                //radius: width/2
                color: theme.favorite.replace(/#/g, "#77");
                visible: gameData.favorite
                Image {
                    id: favicon_icon
                    source: "../assets/star-fill.svg"
                    asynchronous: true
                    anchors.fill: parent
                    anchors.margins: vpx(8) 
                    ColorOverlay {
                        anchors.fill: favicon_icon
                        source: favicon_icon
                        color: theme.favorite
                    }           
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
        color: theme.text

        horizontalAlignment : Text.AlignHCenter
        verticalAlignment : Text.AlignVCenter
        wrapMode: Text.Wrap

        visible: model.assets.boxFront === ""
        
    }
}