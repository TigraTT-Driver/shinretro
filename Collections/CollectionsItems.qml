import QtQuick 2.15
import QtGraphicalEffects 1.12
import "../Global"  

Item {
    id: item_collection

    property var isCurrentItem: PathView.isCurrentItem
    property var clearedShortname: clearShortname(modelData.shortName)
    property var collectionAltColor: {
        if (dataConsoles[clearedShortname] !== undefined) {
            return accentColorNr != 0 ? dataConsoles[clearedShortname].altColor : dataConsoles[clearedShortname].altColor2
        } else {
            return accentColorNr != 0 ? dataConsoles["default"].altColor : dataConsoles["default"].altColor2
        }
    }

    width: PathView.currentWidth
    height: PathView.currentHeight

    Component {
        id: cpnt_collection_bg

        Item {
            anchors.fill: parent

            Rectangle {
                anchors.fill: parent
                color: collectionAltColor
            }

            Image {
                id: img_collection_bg
                width: parent.width
                height: parent.height
                asynchronous: true
                source: "../assets/collections/" + clearedShortname + "/art.jpg"
                fillMode: Image.PreserveAspectCrop
                visible: false
            }

            Image {
                id: img_collection_bg_fallback
                width: parent.width
                height: parent.height
                asynchronous: true
                source: "../assets/collections/default/art.jpg"
                fillMode: Image.PreserveAspectCrop
                visible: false
            }

            Desaturate {
                anchors.fill: img_collection_bg.status == Image.Error ? img_collection_bg_fallback : img_collection_bg
                source: img_collection_bg.status == Image.Error ? img_collection_bg_fallback : img_collection_bg
                desaturation: isCurrentItem ? 0 : 1
                Behavior on desaturation {
                    NumberAnimation { duration: 200; }
                }
            }

            GameVideo {
                game: currentCollection
                anchors.fill: img_collection_bg
                playing: isCurrentItem && collectionVideo != "1"
                sound: collectionVideoMute
            }

            Rectangle {
                id: msk_collection_bg
                anchors.fill: parent
                color: colorScheme[theme].secondary
                opacity: isCurrentItem ? 0 : 0.90
                Behavior on opacity {
                    NumberAnimation { duration: 300; }
                }
            }

            Rectangle {
                anchors.fill: parent
                color: "transparent"
                border {
                    width: vpx(5)
                    color: collectionAltColor
                }
                opacity: isCurrentItem
                Behavior on opacity {
                    NumberAnimation { duration: 250; }
                }
            }
        }

    }

    Loader {
        id: loader_collections_items
        anchors.fill: parent
        sourceComponent: cpnt_collection_bg
        asynchronous: true
        active: ( root.state === "collections" )
    }

}