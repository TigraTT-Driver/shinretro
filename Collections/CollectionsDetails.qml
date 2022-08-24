import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    property var isCurrentItem: PathView.isCurrentItem
    property var shortname: clearShortname(modelData.shortName)
    property var manufacturer: dataConsoles[shortname].manufacturer || null
    property var release: dataConsoles[shortname].release || null
    property var manufacturerColor: (manufacturer !== null) ? dataManufacturers[manufacturer].color : "black"

    width: PathView.view.width
    height: PathView.view.height
    opacity: isCurrentItem

    Component {
        id: cpnt_collection_details

        Item {
            anchors.fill: parent

            Item {
                id: img_collection_logo
                width: vpx(325)
                height: vpx(115)
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: vpx(90)
                }

                Image {
                    id: img_logo_region
                    anchors.fill: parent
                    source: "../assets/collections/"+shortname+"/logo_"+region+"_"+logoVariant+".svg"
                    verticalAlignment: Image.AlignBottom
                    fillMode: Image.PreserveAspectFit
                    visible: logoVariant == "color"
                    antialiasing: true
                }
                Image {
                    id: img_logo
                    anchors.fill: parent
                    source: "../assets/collections/"+shortname+"/logo_"+logoVariant+".svg"
                    verticalAlignment: Image.AlignBottom
                    fillMode: Image.PreserveAspectFit
                    visible: logoVariant == "color" && img_logo_region.status == Image.Error
                    antialiasing: true
                }
                ColorOverlay {
                    anchors.fill: (img_logo_region.status == Image.Error) ? img_logo : img_logo_region
                    source: (img_logo_region.status == Image.Error) ? img_logo : img_logo_region
                    color: colorScheme[theme].icons
                    visible: logoVariant !== "color"
                    antialiasing: true
                }
            }

            Text {
                color: colorScheme[theme].text
                width: parent.width * 0.7
                anchors {
                    bottom: txt_collection_games.top
                    horizontalCenter: txt_collection_games.horizontalCenter
                }
                text: modelData.name
                font {
                    family: global.fonts.condensed
                    pixelSize: vpx(42 * fontScalingFactor)
                }
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
                visible: img_logo.status === Image.Error
            }

            Text {
                id: txt_collection_games
                anchors {
                    top: img_collection_logo.bottom
                    topMargin: vpx(10)
                    horizontalCenter: img_collection_logo.horizontalCenter
                }
                text: modelData.games.count + " " + dataText[lang].collectionDetails_gamesAvailable
                font {
                    family: robotoSlabLight.name
                    pixelSize: vpx(20 * fontScalingFactor)
                }
                color: colorScheme[theme].accent
            }

            Row {
                id: row_collection_manufacturer
                anchors {
                    top: txt_collection_games.bottom
                    topMargin: vpx(5)
                    horizontalCenter: img_collection_logo.horizontalCenter
                }
                spacing: vpx(10)

                Rectangle {
                    width: vpx(75)
                    height: vpx(30)
                    color: "transparent"
                    Item {
                        width: vpx(55)
                        height: vpx(15 * fontScalingFactor)
                        anchors.centerIn: parent

                        Image {
                            id: img_manufacturer
                            anchors.fill: parent
                            source: (manufacturer !== null) ? "../assets/manufacturers/logo/" + manufacturer : ""
                            fillMode: Image.PreserveAspectFit
                            visible: false
                            antialiasing: true
                        }
                        ColorOverlay {
                            anchors.fill: img_manufacturer
                            source: img_manufacturer
                            color: manufacturerColor
                            antialiasing: true
                        }
                    }
                    visible: (img_manufacturer.status === Image.Ready || manufacturer !== null)
                }

                Text {
                    id: txt_collection_release
                    text: release
                    anchors {
                        verticalCenter: row_collection_manufacturer.verticalCenter
                    }
                    font {
                        family: montserratBold.name
                        weight: Font.Medium
                        pixelSize: vpx(14 * fontScalingFactor)
                    }
                    bottomPadding: vpx(2)
                    color: (manufacturerColor !== '#ffffff') ? manufacturerColor : "black"
                }
            }
        }
    }

    Loader {
        anchors.fill: parent
        sourceComponent: cpnt_collection_details
        asynchronous: true
        active: root.state === "collections"
    }

}
