import QtQuick 2.15
import QtGraphicalEffects 1.12
import QtMultimedia 5.15

Item {
    id: root
    property var game
    property bool playing
    property bool sound

    onGameChanged: {
        videoPreviewLoader.sourceComponent = undefined;
        videoDelay.restart();
    }

    onPlayingChanged: {
        videoPreviewLoader.sourceComponent = undefined;
        videoDelay.restart();
    }

    // Timer to show the video
    Timer {
        id: videoDelay

        interval: 600
        onTriggered: {
            if (playing && game && game.assets.videos.length) {
                videoPreviewLoader.sourceComponent = videoPreviewWrapper;
            }
        }
    }

    Component {
        id: videoPreviewWrapper

        Video {
            id: videocomponent

            anchors.fill: parent
            source: game.assets.videoList.length ? game.assets.videoList[0] : ""
            fillMode: VideoOutput.PreserveAspectCrop
            muted: sound
            loops: MediaPlayer.Infinite
            autoPlay: true
            visible: game.assets.videoList.length
        }
    }

    Item {
        id: videocontainer

        anchors.fill: parent

        Loader {
            id: videoPreviewLoader
            asynchronous: true
            anchors { fill: parent }
        }
    }

}