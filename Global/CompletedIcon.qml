import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    id: completedtag
    property double parentImageWidth

    visible: (gameData.extra.completed !== undefined) && (gameData.extra.completed.toString() === 'True') ? true : false
    anchors {
        bottom: parent.bottom
        left: parent.left
        right: parent.right
    }
    width: parent.width
    height: parent.height / 5
    scale: isCurrentItem ? 1.1 : 1
    Behavior on scale { NumberAnimation { duration: 100 } }

    Image {
        id: completedbg
        anchors.centerIn: parent
        source: "../assets/ribbon.svg"
        fillMode: Image.PreserveAspectFit
        width: (parentImageWidth * 0.75) > 125 ? 125 : parentImageWidth * 0.75
    }

    Text {
        anchors {
            centerIn: completedbg
            verticalCenterOffset: vpx(-3)
        }
        text: dataText[lang].games_completed
        font {
            family: montserratMedium.name
            weight: Font.Bold
            pixelSize: (parentImageWidth * 0.75) > 125 ? vpx(10) : vpx((parentImageWidth * 0.75) / 12)
        }
        color: colorScheme[theme].textlight
        z: 15
    }

    ColorOverlay {
        anchors.fill: completedbg
        source: completedbg
        cached: true
        color: colorScheme[theme].completed
        z: 10
    }

}