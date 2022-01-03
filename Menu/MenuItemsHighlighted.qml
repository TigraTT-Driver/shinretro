import QtQuick 2.15

Item {
    Rectangle {
        width: parent.width
        height: vpx(2)
        anchors {
            bottom: parent.bottom; bottomMargin: -vpx(4)
        }
        color: colorScheme[theme].accentalt
    }
}
