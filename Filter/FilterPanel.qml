import QtQuick 2.15


FocusScope {
    id: root

    property alias withTitle: itemTitle.text
    property alias withMultiplayer: itemMultiplayer.checked
    property alias withFavorite: itemFavorite.checked
    property alias panelColor: panel.color
    property color textColor: colorScheme[theme].filters

    width: content.width
    height: content.height
    opacity: 0.95
    Rectangle {
        id: panel
        color: colorScheme[theme].main
        anchors.fill: parent
    }

    Column {
        id: content

        property int normalTextSize: vpx(20 * fontScalingFactor)
        property int selectedIndex: 0
        padding: vpx(20)
        spacing: vpx(8)

        width: vpx(350)

        TextLine {
            id: itemTitle

            placeholder: glyphs.search
            placeholderColor: colorScheme[theme].textalt
            textColor: root.textColor
            fontSize: vpx(20 * fontScalingFactor)

            focus: true
            KeyNavigation.down: itemFavorite
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: parent.padding
            anchors.rightMargin: parent.padding
        }

        CheckBox {
            id: itemFavorite
            text: dataText[lang].home_favorites
            textColor: root.textColor
            fontSize: vpx(20 * fontScalingFactor)

            KeyNavigation.down: itemMultiplayer
        }

        CheckBox {
            id: itemMultiplayer
            text: dataText[lang].games_filterMultiplayer
            textColor: root.textColor
            fontSize: vpx(20 * fontScalingFactor)
        }
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