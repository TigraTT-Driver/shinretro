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
                height: parent.height
                anchors {
                    verticalCenter: parent.verticalCenter
                }

                ListView {
                    id: lv_menu
                    width: contentItem.childrenRect.width
                    height: vpx(22)
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
                        width: vpx(60)
                        height: vpx(22)
                        visible: osc === "No"
                        Image {
                            id: menu_input_LB
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            source: "../assets/buttons/"+controlScheme+"/input_BTN-LB.svg"
                            width: parent.width * 0.55
                            fillMode: Image.PreserveAspectFit
                            antialiasing: true
                            visible: false
                        }
                        ColorOverlay {
                            anchors.fill: menu_input_LB
                            source: menu_input_LB
                            color: colorScheme[theme].accentalt
                            antialiasing: true 
                        }
                    }

                    delegate: MenuItems {}

                    footer: Item {
                        width: vpx(60)
                        height: vpx(22)
                        visible: osc === "No"
                        Image {
                            id: menu_input_RB
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            source: "../assets/buttons/"+controlScheme+"/input_BTN-RB.svg"
                            width: parent.width * 0.55
                            fillMode: Image.PreserveAspectFit
                            antialiasing: true
                            visible: false
                        }
                        ColorOverlay {
                            anchors.fill: menu_input_RB
                            source: menu_input_RB
                            color: colorScheme[theme].accentalt
                            antialiasing: true                    
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

                    spacing: vpx(20)
                }
            }

            Item {
                width: parent.width * 0.5
                height: parent.height
                anchors {
                    right: parent.right; 
                    verticalCenter: parent.verticalCenter
                }

                Item {
                    width: vpx(60)
                    height: vpx(22)
                    visible: osc === "No"
                    anchors {
                        right: parent.right;
                        rightMargin: vpx(290)
                        verticalCenter: parent.verticalCenter
                    }
                    Image {
                        id: menu_input_LT
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        source: "../assets/buttons/"+controlScheme+"/input_BTN-LT.svg"
                        width: parent.width * 0.55
                        //sourceSize.width: width
                        fillMode: Image.PreserveAspectFit
                        antialiasing: true
                        visible: false
                    }
                    ColorOverlay {
                        anchors.fill: menu_input_LT
                        source: menu_input_LT
                        color: colorScheme[theme].accentalt
                        antialiasing: true
                        visible: root.state === "games"
                    }
                }

                Component {
                    id: cmpt_helper_collection
                    Item{
                        visible: ["home","games"].includes(root.state)
                        Image {
                            id: img_helper_collection_region
                            anchors.fill: parent
                            sourceSize.width: width
                            asynchronous: true
                            source: {
                                if (root.state === "collections")
                                    return "";
                                if (root.state === "home")
                                    return "../assets/collections/"+clearShortname(home.currentGame.collections.get(0).shortName)+"/logo_"+region+"_"+logoVariant+".svg"
                                if (root.state === "games")
                                    return "../assets/collections/"+clearShortname(allCollections[currentCollectionIndex].shortName)+"/logo_"+region+"_"+logoVariant+".svg"
                            }
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
                            sourceSize.width: width
                            asynchronous: true
                            source: {
                                if (root.state === "collections")
                                    return "";
                                if (root.state === "home")
                                    return "../assets/collections/"+clearShortname(home.currentGame.collections.get(0).shortName)+"/logo_"+logoVariant+".svg"
                                if (root.state === "games")
                                    return "../assets/collections/"+clearShortname(allCollections[currentCollectionIndex].shortName)+"/logo_"+logoVariant+".svg"
                            }
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
                    width: vpx(60)
                    height: vpx(22)
                    visible: osc === "No"
                    anchors {
                        right: parent.right; leftMargin: -width *2
                        verticalCenter: parent.verticalCenter
                    }
                    Image {
                        id: menu_input_RT
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        source: "../assets/buttons/"+controlScheme+"/input_BTN-RT.svg"
                        width: parent.width * 0.55
                        //sourceSize.width: width
                        fillMode: Image.PreserveAspectFit
                        antialiasing: true
                        visible: false
                    }
                    ColorOverlay {
                        anchors.fill: menu_input_RT
                        source: menu_input_RT
                        color: colorScheme[theme].accentalt
                        visible: root.state === "games"
                        antialiasing: true
                    }
                }
                visible: ["home","games"].includes(root.state)
            }
        }
    }
}