import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    id: favetag
    property double parentImageHeight
    property double parentImageWidth

    anchors {
        fill: parent
    }
    opacity: gameData.favorite ? 1 : 0
    Behavior on opacity {
        NumberAnimation { duration: 100 }
    }

    Text {
        text: glyphs.favoriteBG
        id: favebg
        anchors {
            top: parent.top
            topMargin: (parent.height - parentImageHeight) / 2
            right: parent.right
            rightMargin: (parent.width - parentImageWidth) / 2
        }
        font {
            family: glyphs.name;
            pixelSize: vpx(32)
        }
        color: colorScheme[theme].favorite
        z: 15
    }
    Text {
        text: glyphs.favorite
        anchors {
            top: parent.top
            topMargin: (parent.height - parentImageHeight) / 2 + vpx(2.5)
            right: parent.right
            rightMargin: (parent.width - parentImageWidth) / 2 + vpx(3)
        }
        font {
            family: glyphs.name;
            pixelSize: vpx(13)
        }
        color: colorScheme[theme].text
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