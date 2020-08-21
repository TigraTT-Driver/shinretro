import QtQuick 2.8
import QtGraphicalEffects 1.12
import "qrc:/qmlutils" as PegasusUtils
import "../Global"


Item {
    property var currentGameGenre: model.genre.split(" / ")

    width: ListView.view.width
    height: ListView.view.height
    
    // ALL GAMES INFORMATION
    Component {
        id: cpnt_gameList_details

        Item {
            anchors.fill: parent

            // RELEASE DATE
            Text {
                id: txt_releaseYear
                anchors {
                    top: parent.top; topMargin: -vpx(45)
                }

                text: model.releaseYear || "N/A"
                font {
                    family: global.fonts.sans
                    weight: Font.Black
                    italic: true
                    pixelSize: vpx(140)
                }
                color: "#F0F0F0"

                Behavior on text {
                    PropertyAnimation {
                        target: txt_releaseYear
                        property: "opacity"
                        from: 0
                        to: 1
                        duration: 600
                        easing.type: Easing.OutExpo
                    }
                }

            }

            // RATING
            RatingStars {
                readonly property var rating: (model.rating *5).toFixed(1)
                anchors {
                    top: parent.top; topMargin: parent.height * 0.1
                    right: parent.right
                }
            }

            // TITLE + DEVELOPER + PLAYERS + GENRES + DESCRIPTION
            Column {
                spacing: vpx(10)
                width: parent.width
                anchors {
                    bottom: parent.bottom; bottomMargin: vpx(20)
                }

                Text {
                    width: parent.width
                    text: model.title
                    elide: Text.ElideRight
                    font {
                        family: robotoSlabRegular.name
                        pixelSize: vpx(32)
                    }
                    maximumLineCount: 2
                    wrapMode: Text.Wrap
                    color: "black"
                }

                Row {
                    spacing: vpx(5)

                    Text {
                        text: "Developed by"
                        font {
                            family: global.fonts.sans
                            weight: Font.Light
                            italic: true
                            pixelSize: vpx(14)
                        }
                        color: "black"
                    }

                    Text {
                        text: model.developer
                        font {
                            family: global.fonts.sans
                            weight: Font.Medium
                            pixelSize: vpx(14)
                        }
                        color: "black"
                    }
                }

                Row {
                    spacing: vpx(10)

                    Rectangle {
                        width: txt_players.contentWidth + vpx(20)
                        height: txt_players.contentHeight + vpx(10)
                        color: "black"
                        border {
                            width: vpx(1)
                            color: "black"
                        }
                        
                        Text {
                            id: txt_players
                            property var convertPlayer: model.players > 1 ? "1-"+model.players+" PLAYERS" : "1 PLAYER"
                            anchors.centerIn: parent
                            text: convertPlayer
                            font {
                                family: global.fonts.sans
                                weight: Font.Black
                                pixelSize: vpx(12)
                            }
                            color: "white"
                        }
                    }

                    Repeater {
                        model: currentGameGenre
                        delegate: Rectangle {
                            width: txt_genre.contentWidth + vpx(20)
                            height: txt_genre.contentHeight + vpx(10)
                            color: "white"
                            border {
                                width: vpx(1)
                                color: "black"
                            }
                            
                            Text {
                                id: txt_genre
                                anchors.centerIn: parent
                                text: modelData
                                font {
                                    family: global.fonts.sans
                                    weight: Font.Medium
                                    pixelSize: vpx(12)
                                }
                                color: "black"
                            }
                            visible: (modelData !== "")
                        }
                    }
                }

                Item {
                    width: parent.width
                    height: vpx(68)
                    // anchors.bottom: parent.bottom

                    PegasusUtils.AutoScroll {
                        anchors.fill: parent
                        Text {
                            id: txt_game_description
                            width: parent.width
                            text: (model.description || model.summary) ? (model.description || model.summary) : "No description."
                            font {
                                family: global.fonts.condensed
                                weight: Font.Light
                                pixelSize: vpx(14)
                            }
                            wrapMode: Text.WordWrap
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignJustify
                            color: "black"
                        }
                    }
                }


            }         
        }

    }
        
    Loader {
        id: loader_gameList_details
        width: parent.width * 0.67
        height: parent.height
        asynchronous: true
        sourceComponent: cpnt_gameList_details
        active: games.focus
        visible: status === Loader.Ready
    }

    // BOX ART
    Item {
        width: parent.width * 0.3
        height: parent.height
        anchors {
            right: parent.right
        }

        Item {
            id: item_game_boxart
            width: parent.width
            height: parent.height * 0.85
            anchors.verticalCenter: parent.verticalCenter

            Component {
                id: cpnt_game_boxart

                Image {
                    id: img_game_boxart
                    source: model.assets.boxFront || model.assets.logo
                    anchors.fill: parent
                    // sourceSize.width: width
                    // sourceSize.height: height
                    fillMode: Image.PreserveAspectFit
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    asynchronous: true

                    Behavior on source {
                        PropertyAnimation {
                            target: img_game_boxart
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
                id: loader_game_boxart
                anchors.fill: parent
                asynchronous: true
                sourceComponent: cpnt_game_boxart
                active: games.focus
                visible: status === Loader.Ready
            }

        }
    }

}