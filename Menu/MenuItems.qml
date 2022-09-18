import QtQuick 2.15

Item {
    property bool isCurrentItem: ListView.isCurrentItem

    width: txt_menu_metrics.width
    height: txt_menu_metrics.height
    TextMetrics {
        id: txt_menu_metrics
        text: modelData.name
        font {
            family: global.fonts.condensed
            weight: Font.Bold
            capitalization: Font.AllUppercase
            pixelSize: vpx(16 * fontScalingFactor)
        }
    }

    Text {
        id: txt_menu

        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        text: modelData.title
        color:  isCurrentItem ? colorScheme[theme].accentalt: colorScheme[theme].textalt
        Behavior on color {
            ColorAnimation { duration: 150; }
        }
        font {
            family: global.fonts.condensed
            weight: isCurrentItem ? Font.Bold : Font.Medium
            capitalization: Font.AllUppercase
            pixelSize: vpx(16 * fontScalingFactor)
        }

    }

}
