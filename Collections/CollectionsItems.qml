import QtQuick 2.8
import QtGraphicalEffects 1.12

Item {
    id: item_collection

    property var isCurrentItem: PathView.isCurrentItem
    property var shortname: clearShortname(modelData.shortName)
    property var collectionAltColor: dataConsoles[shortname].altColor

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
                source: "../assets/collections/bg/"+shortname+".jpg"
                fillMode: Image.PreserveAspectCrop
            }

            Desaturate {
                anchors.fill: img_collection_bg
                source: img_collection_bg
                desaturation: isCurrentItem ? 0 : 1
                Behavior on desaturation {
                    NumberAnimation { duration: 200; }
                }
            }

            Rectangle {
                id: msk_collection_bg
                anchors.fill: parent
                color: "white"
                opacity: isCurrentItem ? 0 : 0.85
                Behavior on opacity {
                    NumberAnimation { duration: 300; }
                }
            }

            Rectangle {
                anchors.fill: parent
                color: "transparent"
                border {
                    width: vpx(6)
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