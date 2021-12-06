import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    property var isCurrentItem: PathView.isCurrentItem
    property var shortname: clearShortname(modelData.shortName)
    property var manufacturer: dataConsoles[shortname].manufacturer || null
    property var release: dataConsoles[shortname].release || null

    width: PathView.view.width
    height: PathView.view.height
    opacity: isCurrentItem

    Component {
        id: cpnt_collection_details

        Item {
            anchors.fill: parent

            Item {
                id: img_collection_logo
                width: vpx(250)
                height: vpx(100)
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: vpx(90)
                }

                Image {
                    id: img_logo
                    anchors.fill: parent
                    sourceSize.width: width
                    source: "../assets/logos/"+logoVariant+"/"+shortname+".svg"
                    verticalAlignment: Image.AlignBottom
                    fillMode: Image.PreserveAspectFit
                    ColorOverlay {
                        anchors.fill: img_logo
                        source: img_logo
                        color: theme.icons
                        visible: logoVariant !== "color"
                    }
                }
            }

            Text {
                color: theme.text
                width: parent.width * 0.7
                anchors {
                    bottom: txt_collection_games.top
                    horizontalCenter: txt_collection_games.horizontalCenter
                }
                text: modelData.name
                font {
                    family: global.fonts.condensed
                    pixelSize: vpx(42)
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
                text: modelData.games.count+" games available"
                font {
                    family: robotoSlabLight.name
                    pixelSize: vpx(20)
                }
                color: theme.accent
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
                    width: vpx(60)
                    height: vpx(30)
                    color: "transparent"
                    Item {
                        width: vpx(55)
                        height: vpx(15)
                        anchors.centerIn: parent

                        Image {
                            id: img_manufacturer
                            anchors.fill: parent
                            sourceSize.width: width
                            sourceSize.height: height
                            source: (manufacturer !== null) ? "../assets/manufacturers/logo/"+manufacturer+".svg" : ""
                            fillMode: Image.PreserveAspectFit
                            ColorOverlay {
                                anchors.fill: img_manufacturer
                                source: img_manufacturer
                                color: theme.icons
                            }
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
                        pixelSize: vpx(14)
                    }
                    bottomPadding: vpx(2)
                    color: theme.text
                }
            }

        }

    }

    Loader {
        anchors.fill: parent
        sourceComponent: cpnt_collection_details
        asynchronous: true
        active: ( root.state === "collections" )
    }



}
