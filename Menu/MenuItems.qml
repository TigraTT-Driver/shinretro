import QtQuick 2.8

Item {
    property var isCurrentItem: ListView.isCurrentItem

    width: txt_menu_metrics.width
    height: txt_menu_metrics.height

    TextMetrics {
        id: txt_menu_metrics
        text: modelData.name
        font {
            family: global.fonts.condensed
            weight: Font.Bold
            capitalization: Font.AllUppercase
            pixelSize: vpx(16)
        }
    }

    Text {
        id: txt_menu

        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        text: modelData.name
        color: "black"
        Behavior on color {
            ColorAnimation { duration: 150; }
        }
        font {
            family: global.fonts.condensed
            weight: isCurrentItem ? Font.Bold : Font.Medium
            capitalization: Font.AllUppercase
            pixelSize: vpx(16)
        }

    }

}

