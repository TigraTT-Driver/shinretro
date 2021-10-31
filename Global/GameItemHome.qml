// gameOS theme
// Copyright (C) 2018-2020 Seth Powell 
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

import QtQuick 2.15
import QtGraphicalEffects 1.12
import QtMultimedia 5.15

Item {
id: root
    property var collectionAltColor: dataConsoles[clearShortname(currentCollection.shortName)].altColor
    // NOTE: This is technically duplicated from utils.js but importing that file into every delegate causes crashes
    function steamAppID (gameData) {
        var str = gameData.assets.boxFront.split("header");
        return str[0];
    }

    function steamLogo(gameData) {
        return steamAppID(gameData) + "/logo.png"
    }


    function logo(data) {
    if (data != null) {
        if (data.assets.boxFront.includes("header.jpg")) 
            return steamLogo(data);
        else {
            if (data.assets.logo != "")
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

    Item 
    {
    id: container

        anchors.fill: parent
        Behavior on opacity { NumberAnimation { duration: 200 } }

        Image {
        id: screenshot

            anchors.fill: parent
            anchors.margins: vpx(3)
            source: modelData ? modelData.assets.screenshots[0] || modelData.assets.background || "" : ""
            fillMode: Image.PreserveAspectCrop
            sourceSize: Qt.size(screenshot.width, screenshot.height)
            smooth: false
            asynchronous: true
            scale: selected ? 1.1 : 1
            Behavior on opacity { NumberAnimation { duration: 200 } } 
        }

        Image {
        id: favelogo

            anchors.fill: parent
            anchors.centerIn: parent
            anchors.margins: root.width/10
            property var logoImage: (gameData && gameData.collections.get(0).shortName === "retropie") ? gameData.assets.boxFront : (gameData.collections.get(0).shortName === "steam") ? logo(gameData) : gameData.assets.logo
            source: modelData ? logoImage || "" : ""
            sourceSize: Qt.size(favelogo.width, favelogo.height)
            fillMode: Image.PreserveAspectFit
            asynchronous: true
            smooth: true
            scale: selected ? 1.1 : 1
            Behavior on scale { NumberAnimation { duration: 100 } }
            z: 10
        }
        Rectangle {
            anchors.fill: parent
            color: "black"
                border {
                    width: vpx(6)
                    color: collectionAltColor
                }
            opacity: doubleFocus ? 0.8 : 0
            Behavior on opacity {
                NumberAnimation { duration: 200; }
            }
            Component {
            id: gameVideo

                GameVideo {
                    width: collectionList.cellWidth
                    height: collectionList.cellHeight
                    game: search ? search.currentGame(collectionList.currentIndex) : ""
                    selected: collectionList.focus
                }
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
            border.width: vpx(1)
            border.color: "white"
            opacity: 0.1
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

            visible: model.assets.logo === ""
            
        }

        Rectangle {
            anchors.fill: parent
            color: "transparent"
            opacity: doubleFocus ? 0.8 : 0
            Behavior on opacity {
                NumberAnimation { duration: 200; }
            }
        }

        Rectangle {
            anchors.fill: parent
            color: "transparent"
            border {
                width: vpx(5)
                color: "#F3C03B"
            }
            visible: model.favorite && root.state === "games"
        }
        
    }


