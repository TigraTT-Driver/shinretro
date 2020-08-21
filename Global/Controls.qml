import QtQuick 2.8
import QtGraphicalEffects 1.12

Item {

    property var message: parent.message
    property var text_color: parent.text_color
    property var front_color: parent.front_color
    property var back_color: parent.back_color
    property var input_button: parent.input_button
    
    width: childrenRect.width
    height: childrenRect.height

    Rectangle {
        width: row_button.width + vpx(20)
        height: row_button.height + vpx(10)
        anchors {
            top: row_button.top; topMargin: -vpx(5)
            right: row_button.right; rightMargin: -vpx(12)
        }
        color: back_color
        antialiasing: true
        border {
            width: vpx(2)
            color: front_color
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

    Row {
        id: row_button
        spacing: vpx(5)

        Text {
            text: message
            font {
                family: global.fonts.sans
                weight: Font.Light
                italic: true
                pixelSize: vpx(12)
                capitalization: Font.AllUppercase
            }
            topPadding: vpx(1)
            rightPadding: vpx(7)
            color: text_color
        }

        Image {
            height: vpx(16)
            source: "../assets/controls/button_"+input_button+".svg"
            fillMode: Image.PreserveAspectFit
        }
    }
}