import QtQuick 2.8
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
        color: "#35000000"
        source: parent
    }

    Rectangle {
        width: parent.width + 2
        height: parent.height + 2
        x: -1
        y: -1
        color: "white"
        border {
            width: 1
            color: "#D1D1D1"
        }

        Item {
            id: menu_inner
            width: parent.width
            height: parent.height * 0.24
            anchors {
                verticalCenter: parent.verticalCenter
            }

            ListView {
                id: lv_menu
                implicitWidth: contentItem.childrenRect.width
                height: parent.height

                anchors {
                    left: parent.left
                    leftMargin: vpx(50)
                }

                orientation: ListView.Horizontal
                currentIndex: currentMenuIndex
                onCurrentIndexChanged: {
                    api.memory.set("currentMenuIndex", currentMenuIndex)
                }

                model: dataMenu

                header: Item {
                    width: vpx(68)
                    height: vpx(18)
                    Rectangle {
                        width: parent.width * 0.55
                        height: parent.height
                        anchors {
                            left: parent.left
                        }
                        color: "white"
                        radius: width /4
                        border {
                            width: vpx(1)
                        }
                        Text {
                            text: "LB"
                            anchors.centerIn: parent
                            font {
                                family: global.fonts.sans
                                pixelSize: parent.height * 0.6
                            }
                        }
                    }
                }

                delegate: MenuItems {}

                footer: Item {
                    width: vpx(68)
                    height: vpx(18)
                    Rectangle {
                        width: parent.width * 0.55
                        height: parent.height
                        anchors {
                            right: parent.right
                        }
                        color: "white"
                        radius: width /4
                        border {
                            width: vpx(1)
                        }
                        Text {
                            text: "RB"
                            anchors.centerIn: parent
                            font {
                                family: global.fonts.sans
                                pixelSize: parent.height * 0.6
                            }
                        }
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

                spacing: vpx(70)

            }

        }

        Item {
            width: height * 2.5
            height: parent.height * 0.65
            anchors {
                right: parent.right; rightMargin: parent.width * 0.19
                verticalCenter: parent.verticalCenter
            }

            Image {
                anchors {
                    left: parent.left; leftMargin: -width *2
                    verticalCenter: parent.verticalCenter
                }
                width: vpx(25)
                source: "../assets/controls/button_LT.png"
                sourceSize.width: width
                fillMode: Image.PreserveAspectFit
                visible: root.state === "games"
            }

            Component {
                id: cpnt_helper_collection

                Image {
                    id: img_helper_collection
                    anchors.fill: parent
                    sourceSize.width: width
                    asynchronous: true
                    source: {
                        if (root.state === "collections")
                            return "";
                        if (root.state === "home")
                            return "../assets/collections/logo/"+clearShortname(home.currentGame.collections.get(0).shortName)+".png"
                        if (root.state === "games")
                            return "../assets/collections/logo/"+clearShortname(allCollections[currentCollectionIndex].shortName)+".png"
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
                }
            }

            Loader {
                id: loader_helper_collection
                anchors.fill: parent
                asynchronous: true
                sourceComponent: cpnt_helper_collection
                active: ["home","games"].includes(root.state)
                visible: status === Loader.Ready
            }

            Image {
                anchors {
                    right: parent.right; rightMargin: -width *2
                    verticalCenter: parent.verticalCenter
                }
                width: vpx(25)
                source: "../assets/controls/button_RT.png"
                sourceSize.width: width
                fillMode: Image.PreserveAspectFit
                visible: root.state === "games"
            }

            visible: ["home","games"].includes(root.state)
        }


    }

}