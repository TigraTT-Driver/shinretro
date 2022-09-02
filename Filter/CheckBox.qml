import QtQuick 2.15

Row {
    id: root

    property alias fontSize: label.font.pixelSize
    property alias text: label.text
    property alias textColor: label.color
    property bool checked: false
    spacing: vpx(8)

    Item {
        width: parent.fontSize * 1.4
        height: width

        anchors.verticalCenter: parent.verticalCenter

        Text {
            text: root.checked ? glyphs.enabled : glyphs.disabled
            color: colorScheme[theme].filters
            font {
                family: glyphs.name
                pixelSize: vpx(16 * fontScalingFactor)
            }

            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Text {
        id: label

        height: parent.height
        verticalAlignment: Text.AlignVCenter

        color: colorScheme[theme].filters
        font {
            bold: root.activeFocus
            family: globalFonts.sans
        }
    }

    Keys.onPressed: {
        if (api.keys.isAccept(event) && !event.isAutoRepeat) {
            event.accepted = true;
            checked = !checked;
        }
    }

}