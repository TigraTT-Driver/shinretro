import QtQuick 2.8

Item {
    property var isCurrentItem: ListView.isCurrentItem

    width: txt_menu_metrics.width + vpx(18)
    height: txt_menu_metrics.height + vpx(8)
    y: -vpx(6)

    TextMetrics {
        id: txt_menu_metrics
        text: modelData.name
        font {
            family: montserratMedium.name
            italic: true
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

        topPadding: -vpx(2)
        leftPadding: -vpx(8)

        text: modelData.name
        color: isCurrentItem ? "white" : "black"
        Behavior on color {
            ColorAnimation { duration: 150; }
        }
        font {
            family: montserratMedium.name
            italic: isCurrentItem
            capitalization: Font.AllUppercase
            pixelSize: vpx(16)
        }

    }

}

