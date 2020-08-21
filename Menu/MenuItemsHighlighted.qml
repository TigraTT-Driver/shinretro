import QtQuick 2.8

Rectangle {
    y: -vpx(6)
    color: "black"
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
