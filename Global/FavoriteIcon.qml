import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    id: favetag
    property var parentImageWidth

    anchors {
        fill: parent
    }
    opacity: gameData.favorite ? 1 : 0
    Behavior on opacity {
        NumberAnimation { duration: 100 }
    }

    Image {
        id: favebg
        anchors {
            top: parent.top
            topMargin: vpx(0)
            right: parent.right
            rightMargin: (parent.width - parentImageWidth) / 2
        }
        source: "../assets/favebg.svg"
        width: vpx(32)
        height: vpx(32)
        sourceSize {
            width: vpx(32)
            height: vpx(32)
        }
        visible: false
    }

    ColorOverlay {
        anchors.fill: favebg
        source: favebg
        color: colorScheme[theme].favorite
        z: 15
    }

    Image {
        id: star
        anchors {
            top: parent.top
            topMargin: vpx(2.5)
            right: parent.right
            rightMargin: (parent.width - parentImageWidth) / 2 + vpx(3)
        }
        source: "../assets/star.svg"
        width: vpx(13)
        height: vpx(13)
        sourceSize {
            width: vpx(32)
            height: vpx(32)
        }
        smooth: true
        z: 20
    }

    z: 25
    layer.enabled: true
    layer.effect: OpacityMask {
        maskSource: Item {
            width: favetag.width
            height: favetag.height
            Rectangle {
                anchors.centerIn: parent
                width: favetag.width
                height: favetag.height
            }
        }
    }

}