import QtQuick 2.8
import QtGraphicalEffects 1.12

Item {
    width: vpx(100)
    height: vpx(20)

    property variant starsMatrix: [
        { source: getStars(0, rating) },
        { source: getStars(1, rating) },
        { source: getStars(2, rating) },
        { source: getStars(3, rating) },
        { source: getStars(4, rating) }
    ]

    function getStars(index, rate) {
        if (rate <= index) {
            return no_star
        }
        else if (rate <= index+0.5) {
            return half_star
        }
        else {
            return star
        }
    }

    function getBackgroundColor(rate) {
        if (rate < 2.5) {
            return "#B5714B"
        }
        else if (rate < 4) {
            return "#F4F4F4"
        }
        else {
            return "#FFCE00"
        }
    }

    Component {
        id: no_star
        Image {
            source: "../assets/no_star.png"
            width: vpx(12)
            height: vpx(12)
            asynchronous: true
            sourceSize.width: width
            sourceSize.height: height
            fillMode: Image.PreserveAspectFit
        }
    }

    Component {
        id: half_star
        Image {
            source: "../assets/half_star.png"
            width: vpx(12)
            height: vpx(12)
            asynchronous: true
            sourceSize.width: width
            sourceSize.height: height
            fillMode: Image.PreserveAspectFit
        }
    }

    Component {
        id: star
        Image {
            source: "../assets/star.png"
            width: vpx(12)
            height: vpx(12)
            asynchronous: true
            sourceSize.width: width
            sourceSize.height: height
            fillMode: Image.PreserveAspectFit
        }
    }

    Rectangle {
        id: rect_stars
        width: rating_stars.width + vpx(10)
        height: rating_stars.height + vpx(5)
        anchors {
            top: rating_stars.top; topMargin: -vpx(2)
            left: rating_stars.left; leftMargin: -vpx(3)
        }
        color: getBackgroundColor(rating)
        antialiasing: true

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

    Text {
        id: txt_rating
        anchors {
            top: rect_stars.top; topMargin: -vpx(1)
            left: rect_stars.right; leftMargin: vpx(3)
        
        }
        text: rating
        font {
            family: global.fonts.sans
            pixelSize: vpx(16)
        }
        color: "black"
    }

    Row {
        id: rating_stars
        spacing: vpx(4)

        Repeater {
            model: starsMatrix
            delegate: Loader {
                sourceComponent: modelData.source
                visible: status == Loader.Ready
            }
        }
    }

}