// Pegasus Frontend
// Copyright (C) 2017-2018  Mátyás Mustoha
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

Item {
    property var game

    visible: game

    readonly property double currentMaxOpacity: game && game.assets.background && 1.0 || 0.35
    readonly property string currentSource: {
        if (!game)
            return "";
        return game.assets.background
            || game.assets.screenshots[0]
            || game.assets.titlescreen[0]
            || "";
    }
    onCurrentSourceChanged: delay.restart()

    states: State {
        name: "alt"
        PropertyChanges { target: imgA; opacity: currentMaxOpacity }
        PropertyChanges { target: imgB; opacity: 0 }
    }
    transitions: Transition {
        NumberAnimation { properties: 'opacity'; duration: 500 }
    }

    Timer {
        id: delay
        interval: 200
        onTriggered: {
            if (state == "") {
                imgA.source = currentSource;
                state = "alt";
            } else {
                imgB.source = currentSource;
                state = "";
            }
        }
    }

    Image {
        id: imgA
        anchors.fill: parent
        opacity: 0
        visible: opacity > 0 && source

        sourceSize { width: 512; height: 512 }
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        smooth: false
    }
    Image {
        id: imgB
        anchors.fill: parent
        opacity: currentMaxOpacity
        visible: opacity > 0 && source

        sourceSize { width: 512; height: 512 }
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        smooth: false
    }

    LinearGradient {
        z: parent.z + 1
        width: parent.width * 0.75
        anchors {
            top: parent.top
            right: parent.right
            bottom: parent.bottom
        }
        start: Qt.point(0, 0)
        end: Qt.point(width, 0)
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#00000000" }
            GradientStop { position: 0.5; color: "#cc000000" }
        }
    }
}