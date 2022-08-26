import QtQuick 2.15
import QtGraphicalEffects 1.12
import "../Global"

FocusScope {
    focus: menu.focus
    DropShadow {
        anchors.fill: parent
        horizontalOffset: 0
        verticalOffset: vpx(5)
        radius: 24
        samples: 22
        spread: 0.2
        color: colorScheme[theme].secondary
        source: parent
    }

    Rectangle {
        width: parent.width + 2
        height: parent.height + 2
        x: -1
        y: -1
        color: colorScheme[theme].main
        border {
            width: 1
            color: colorScheme[theme].secondary
        }

        Item {
            width: parent.width * 0.9
            height: parent.height * 0.7
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            Item {
                id: menu_inner
                width: parent.width * 0.5
                height: parent.height * fontScalingFactor
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }

                ListView {
                    id: lv_menu
                    width: contentItem.childrenRect.width
                    height: vpx(22 * fontScalingFactor)
                    anchors {
                        verticalCenter: parent.verticalCenter
                    }

                    orientation: ListView.Horizontal
                    currentIndex: currentMenuIndex
                    onCurrentIndexChanged: {
                        api.memory.set("currentMenuIndex", currentMenuIndex)
                    }

                    model: dataMenu

                    header: Item {
                        width: vpx(40)
                        height: vpx(22  * fontScalingFactor)
                        visible: osc === 0
                        anchors.verticalCenter: parent.verticalCenter
                        Text {
                            text: osdScheme[controlScheme].BTNLB
                            font {
                                family: glyphs.name;
                                pixelSize:{
                                    if (((controlScheme != "Universal") || (controlScheme != "Universal-JP")) && (fontScalingFactor > 1.1))
                                        parent.height * 0.66
                                    else parent.height * 0.9
                                }
                            }
                            color: colorScheme[theme].accentalt
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                        }
                    }

                    delegate: MenuItems {}

                    footer: Item {
                        width: vpx(40)
                        height: vpx(22  * fontScalingFactor)
                        visible: osc === 0
                        anchors.verticalCenter: parent.verticalCenter
                        Text {
                            text: osdScheme[controlScheme].BTNRB
                            font {
                                family: glyphs.name;
                                pixelSize:{
                                    if (((controlScheme != "Universal") || (controlScheme != "Universal-JP")) && (fontScalingFactor > 1.1))
                                        parent.height * 0.66
                                    else parent.height * 0.9
                                }
                            }
                            color: colorScheme[theme].accentalt
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                        }
                    }

                    highlight: MenuItemsHighlighted {}
                    highlightRangeMode: ListView.ApplyRange
                    highlightResizeDuration: root.width * 0.1
                    highlightResizeVelocity: root.width * 0.1
                    highlightMoveDuration: root.width * 0.1
                    highlightMoveVelocity: -1

                    interactive: false
                    focus: menu.focus
                    Component.onCompleted: positionViewAtIndex(currentMenuIndex, ListView.Beginning)

                    spacing: vpx(20 * fontScalingFactor)
                }
            }

            Item {
                width: parent.width * 0.5
                height: parent.height
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }

                Item {
                    width: vpx(40)
                    height: vpx(22 * fontScalingFactor)
                    visible: osc === 0
                    anchors {
                        right: parent.right
                        rightMargin: vpx(290)
                        verticalCenter: parent.verticalCenter
                    }
                    Text {
                        text: osdScheme[controlScheme].BTNLT
                        font {
                            family: glyphs.name
                            pixelSize:{
                                if (((controlScheme != "Universal") || (controlScheme != "Universal-JP")) && (fontScalingFactor > 1.3))
                                    parent.height * 0.7
                                else parent.height * 0.9
                            }
                        }
                        color: colorScheme[theme].accentalt
                        visible: root.state === "games" && gamesPgUpDownFunction === 'Collections'
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Component {
                    id: cmpt_helper_collection
                    Item {
                        visible: ["home","games"].includes(root.state)
                        Image {
                            id: img_helper_collection_region
                            anchors.fill: parent
                            asynchronous: true
                            source: {
                                if (root.state === "collections")
                                    return "";
                                if (root.state === "home")
                                    return "../assets/collections/" + clearShortname(home.currentGame.collections.get(0).shortName) + "/logo_" + region + "_" + logoVariant
                                if (root.state === "games")
                                    return "../assets/collections/" + clearShortname(allCollections[currentCollectionIndex].shortName) + "/logo_" + region + "_" + logoVariant
                            }
                            sourceSize.width: width
                            fillMode: Image.PreserveAspectFit
                            horizontalAlignment: Image.AlignHCenter
                            verticalAlignment: Image.AlignVCenter
                            Behavior on source {
                                PropertyAnimation {
                                    target: img_helper_collection_region
                                    property: "opacity"
                                    from: 0
                                    to: 1
                                    duration: 600
                                    easing.type: Easing.OutExpo
                                }
                            }
                            visible: logoVariant == "color"
                            antialiasing: true
                        }
                        Image {
                            id: img_helper_collection
                            anchors.fill: parent
                            asynchronous: true
                            source: {
                                if (root.state === "collections")
                                    return "";
                                if (root.state === "home")
                                    return "../assets/collections/" + clearShortname(home.currentGame.collections.get(0).shortName) + "/logo_" + logoVariant
                                if (root.state === "games")
                                    return "../assets/collections/" + clearShortname(allCollections[currentCollectionIndex].shortName) + "/logo_" + logoVariant
                            }
                            sourceSize.width: width
                            fillMode: Image.PreserveAspectFit
                            horizontalAlignment: Image.AlignHCenter
                            verticalAlignment: Image.AlignVCenter
                            Behavior on source {
                                PropertyAnimation {
                                    target: img_helper_collection
                                    property: "opacity"
                                    from: 0
                                    to: 1
                                    duration: 600
                                    easing.type: Easing.OutExpo
                                }
                            }
                            visible: logoVariant == "color" && img_helper_collection_region.status == Image.Error
                            antialiasing: true
                        }

                        ColorOverlay{
                            anchors.fill: (img_helper_collection_region.status == Image.Error) ? img_helper_collection : img_helper_collection_region
                            source: (img_helper_collection_region.status == Image.Error) ? img_helper_collection : img_helper_collection_region
                            color: colorScheme[theme].icons
                            visible: logoVariant !== "color"
                            antialiasing: true
                        }
                    }
                }

                Loader {
                    id: loader_helper_collection
                    sourceComponent: cmpt_helper_collection
                    width: vpx(250)
                    height: parent.height
                    anchors {
                        right: parent.right
                        rightMargin: vpx(35)
                    }
                    asynchronous: true
                    active: ["home","games"].includes(root.state)
                    visible: status === Loader.Ready
                }

                Item {
                    width: vpx(40)
                    height: vpx(22 * fontScalingFactor)
                    visible: osc === 0
                    anchors {
                        right: parent.right
                        leftMargin: -width * 2
                        verticalCenter: parent.verticalCenter
                    }
                    Text {
                        text: osdScheme[controlScheme].BTNRT
                        font {
                            family: glyphs.name
                            pixelSize:{
                                if (((controlScheme != "Universal") || (controlScheme != "Universal-JP")) && (fontScalingFactor > 1.3))
                                    parent.height * 0.75
                                else parent.height * 0.9
                            }
                        }
                        color: colorScheme[theme].accentalt
                        visible: root.state === "games" && gamesPgUpDownFunction === 'Collections'
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                    }
                }
                visible: ["home","games"].includes(root.state)
            }
        }
    }

}
