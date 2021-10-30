import QtQuick 2.15
import QtGraphicalEffects 1.12
import SortFilterProxyModel 0.2
import QtMultimedia 5.15
import "qrc:/qmlutils" as PegasusUtils
import "../Global"

FocusScope {
    focus: games.focus

    state: "all"

    property int currentGameIndex: 0
    property var currentGame: {
        if (gv_games.count === 0)
            return null;
        if (games.state === "favorites")
            return currentCollection.games.get(filteredGames.mapToSource(currentGameIndex))

        return currentCollection.games.get(currentGameIndex)
    }

    SortFilterProxyModel {
        id: filteredGames
        sourceModel: currentCollection.games
        filters: ValueFilter { roleName: "favorite"; value: true; }
    }

    Behavior on focus {
        ParallelAnimation {
            PropertyAnimation {
                target: skew_color
                property: "anchors.leftMargin"
                from: parent.width * 0.97
                to: parent.width * 0.77
                duration: 250
            }
        }
    }

    //Color retangle
    Rectangle {
        id: skew_color
        readonly property var touch_color: dataConsoles[clearShortname(currentCollection.shortName)].color
        width: parent.width * 0.42
        height: parent.height
        antialiasing: true
        anchors {
            left: parent.left
            leftMargin: parent.width * 0.77
        }
        color: touch_color
        Behavior on color {
            ColorAnimation { duration: 250; }
        }

        transform: Matrix4x4 {
            property real a: 12 * Math.PI / 180
            matrix: Qt.matrix4x4(
                1,      -Math.tan(a),       0,      0,
                0,      1,                  0,      0,
                0,      0,                  1,      0,
                0,      0,                  0,      1
            )
        }
    }

    // Game details
    Item {
        id: item_game_details
        width: parent.width * 0.92 //0.75
        anchors {
            top: parent.top
            bottom: games_bottom.top
            horizontalCenter: parent.horizontalCenter
        }

        Item {
            anchors.fill: parent

            // ALL GAMES INFORMATION
            Component {
                id: cpnt_gameList_details

                Item {
                    readonly property var currentGameGenre: currentGame.genre.split(" / ") || ""
                    anchors.fill: parent

                    // RELEASE DATE
                    Text {
                        id: txt_releaseYear
                        anchors {
                            top: parent.top; topMargin: -vpx(30)
                        }

                        text: currentGame.releaseYear || "N/A"
                        font {
                            family: global.fonts.sans
                            weight: Font.Black
                            italic: true
                            pixelSize: vpx(140)
                        }
                        color: "#202335"

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

                    
                    // TITLE + DEVELOPER + PLAYERS + GENRES + DESCRIPTION
                    Column {
                        spacing: vpx(10)
                        width: parent.width
                        anchors {
                            bottom: parent.bottom; bottomMargin: vpx(20)
                        }

                        Text {
                            width: parent.width
                            text: currentGame.title
                            elide: Text.ElideRight
                            font {
                                family: robotoSlabRegular.name
                                pixelSize: vpx(32)
                            }
                            maximumLineCount: 2
                            wrapMode: Text.Wrap
                            color: "white"
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
                                color: "#757BA0"
                            }

                            Text {
                                text: currentGame.developer
                                font {
                                    family: global.fonts.sans
                                    weight: Font.Medium
                                    pixelSize: vpx(14)
                                }
                                color: "white"
                            }
                        }

                        Row {
                            spacing: vpx(5)
                            // RATING
                            RatingStars {
                                readonly property var rating: (currentGame.rating *5).toFixed(1)
                                // anchors {
                                //     top: parent.top; topMargin: parent.height * 0.1
                                //     right: parent.right
                                // }
                            }
                        }

                        Row {
                            spacing: vpx(10)

                            Rectangle {
                                width: txt_players.contentWidth + vpx(20)
                                height: txt_players.contentHeight + vpx(10)
                                color: "#1C1E2E"
                                border {
                                    width: vpx(1)
                                    color: "#1C1E2E"
                                }

                                Text {
                                    id: txt_players
                                    property var convertPlayer: currentGame.players > 1 ? "1-"+currentGame.players+" PLAYERS" : "1 PLAYER"
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

                            Rectangle {
                                width: txt_favorited.contentWidth + vpx(20)
                                height: txt_favorited.contentHeight + vpx(10)
                                color: "#33F3C03B"

                                Text {
                                    id: txt_favorited
                                    anchors.centerIn: parent
                                    text: "FAVORITED"
                                    font {
                                        family: global.fonts.sans
                                        weight: Font.Black
                                        pixelSize: vpx(12)
                                    }
                                    color: "#F3C03B"
                                }
                                visible: currentGame.favorite
                            }

                            Repeater {
                                model: currentGameGenre
                                delegate: Rectangle {
                                    width: txt_genre.contentWidth + vpx(20)
                                    height: txt_genre.contentHeight + vpx(10)
                                    color: "#1C1E2E"
                                    border {
                                        width: vpx(1)
                                        color: "#1C1E2E"
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
                                        color: "white"
                                    }
                                    visible: (modelData !== "")
                                }
                            }
                        }

                        //Description
                        Item {
                            width: parent.width
                            height: vpx(100)
                            // anchors.bottom: parent.bottom

                            PegasusUtils.AutoScroll {
                                anchors.fill: parent
                                Text {
                                    id: txt_game_description
                                    width: parent.width
                                    text: (currentGame.description || currentGame.summary) ? (currentGame.description || currentGame.summary) : "Sem descrição."
                                    font {
                                        family: global.fonts.condensed
                                        weight: Font.Light
                                        pixelSize: vpx(14)
                                    }
                                    wrapMode: Text.WordWrap
                                    elide: Text.ElideRight
                                    horizontalAlignment: Text.AlignJustify
                                    color: "#757BA0"
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
                active: games.focus && currentGame !== null
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

                        Item {
                            anchors.fill: parent

                            Rectangle {
                                id: rect_boxart
                                width: img_game_boxart.paintedWidth + vpx(15)
                                height: img_game_boxart.paintedHeight + vpx(15)
                                anchors.centerIn: img_game_boxart
                                color: "#1C1E2E"
                            }

                            DropShadow {
                                anchors.fill: rect_boxart
                                horizontalOffset: 0
                                verticalOffset: vpx(5)
                                radius: 24
                                samples: 22
                                spread: 0.2
                                color: "#35000000"
                                source: rect_boxart
                            }

                            Image {
                                id: img_game_boxart
                                source: currentGame.assets.boxFront || currentGame.assets.logo
                                anchors {
                                    fill: parent
                                }
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


                    }

                    Loader {
                        id: loader_game_boxart
                        anchors.fill: parent
                        asynchronous: true
                        sourceComponent: cpnt_game_boxart
                        active: games.focus && currentGame !== null
                        visible: status === Loader.Ready
                    }

                }
            }

        }

        visible: currentGame !== null
    }

    Item {
        anchors.centerIn: parent
        visible: currentGame === null && (games.state === "favorites")
        Column {
            Text {
                anchors.centerIn: parent
                text: "No favorites."
                color: "#7981A8"
                font {
                    family: robotoSlabRegular.name
                    pixelSize: vpx(42)
                }
                
            }
        }
    }

    // Games
    Item {
        id: games_bottom
        width: parent.width
        height: parent.height * 0.50
        anchors {
            bottom: parent.bottom
        }

        Column {
            
        }

        GridView {
            id: gv_games
            width: parent.width * 0.92 //0.75
            height: vpx(260)
            cellWidth: width /6
            cellHeight: height /2
            anchors.horizontalCenter: parent.horizontalCenter

            clip: true
            // interactive: false

            preferredHighlightBegin: height * 0.5
            preferredHighlightEnd: height * 0.5

            currentIndex: currentGameIndex
            onCurrentIndexChanged: currentGameIndex = currentIndex

            model: {
                if (games.state === "favorites")
                    return filteredGames
                return currentCollection.games
            }
            delegate: Item {
                property bool isCurrentItem: GridView.isCurrentItem
                property bool isFocused: games.focus
                property bool doubleFocus: isFocused && isCurrentItem

                width: GridView.view.cellWidth
                height: GridView.view.cellHeight

                Item {
                    anchors {
                        fill: parent
                        margins: vpx(5)
                    }

                    Rectangle {
                        anchors.fill: parent
                        color: "#E5E5E5"
                        visible: !loader_gameList_game.visible
                    }

                    Loader {
                        id: loader_gameList_game
                        anchors.fill: parent

                        asynchronous: true
                        sourceComponent: GameItem {}
                        active: games.focus
                        visible: status === Loader.Ready
                    }
                }
            }

            highlightRangeMode: GridView.ApplyRange
            snapMode: GridView.NoSnap

            focus: games.focus

            Component.onCompleted: {
                positionViewAtIndex(currentGameIndex, GridView.SnapPosition)
            }

            Keys.onPressed: {

                if (event.isAutoRepeat) {
                    return
                }

                if (api.keys.isAccept(event)) {
                    //Accept game sound
                    sfxAccept.play();
                    event.accepted = true;
                    if (currentGame !== null) {
                        api.memory.set("currentCollectionIndex", currentCollectionIndex)
                        api.memory.set("currentMenuIndex", currentMenuIndex)
                        currentGame.launch()
                    }

                }

                if (api.keys.isFilters(event)) {
                    //Accept game sound
                    sfxBack.play();
                    event.accepted = true;
                    if (games.state === "all") {
                        games.state = "favorites"
                    }
                    else {
                        games.state = "all"
                    }
                }

                if (api.keys.isCancel(event)) {
                    //Accept game sound
                    sfxBack.play();
                    event.accepted = true;
                    currentMenuIndex = 1
                }

                if (api.keys.isDetails(event)) {
                    event.accepted = true;
                    if (currentGame !== null) {
                        currentGame.favorite = !currentGame.favorite
                    }

                }

                if (event.key == Qt.Key_Left ) {
                    //navigation sound
                    sfxNav.play();
                }

                if (event.key == Qt.Key_Right) {
                    //navigation sound
                    sfxNav.play();
                }
                if (event.key == Qt.Key_Down) {
                    //navigation sound
                    sfxNav.play();
                }

                if (event.key == Qt.Key_Up) {
                    sfxNav.play();
                }

                if (api.keys.isPageDown(event)) {

                    //navigation sound
                    sfxNav.play();

                    event.accepted = true;

                    if (currentCollectionIndex <= 0)
                        currentCollectionIndex = api.collections.count - 1
                    else
                        currentCollectionIndex--;

                    api.memory.set("currentCollectionIndex", currentCollectionIndex)
                    currentGameIndex = 0
                }

                if (api.keys.isPageUp(event)) {

                    //navigation sound
                    sfxNav.play();

                    event.accepted = true;

                    if (currentCollectionIndex >= api.collections.count - 1) {
                        currentCollectionIndex = 0;
                    }
                    else {
                        currentCollectionIndex++;
                    }

                    api.memory.set("currentCollectionIndex", currentCollectionIndex)
                    currentGameIndex = 0
                }

            }

        }

        
        //Navgation bar
        Component {
            id: cpnt_helper_nav
            Item {
                
                Rectangle {
                    property int heightBar: parent.height - vpx(50)
                    anchors {
                        left: parent.left; 
                        leftMargin: parent.width + 30
                        top: parent.top; topMargin: vpx(6)
                    }
                    width: vpx(2)
                    height: heightBar * ( (currentGameIndex + 1) / gv_games.count )
                    color: "#757BA0"
                }
            }
        }

        Loader {
            id: loader_helper_nav
            width: vpx(50)
            height: gv_games.height
            anchors {
                right: gv_games.left; rightMargin: vpx(25)
                top: gv_games.top;
            }
            asynchronous: true
            sourceComponent: cpnt_helper_nav
            active: games.focus && currentGame !== null
            visible: status === Loader.Ready
        }

    }

    // Counter grid
    Row {
        // anchors {
        //     bottom: parent.bottom; bottomMargin: vpx(35)
        //     right: parent.right; 
        //     rightMargin: + 115
        // }
        anchors {
            bottom: parent.bottom; bottomMargin: vpx(25)
            right: parent.right; 
            rightMargin: parent.width * 0.06
            //verticalCenter: parent.verticalCenter
        }
        Text {
            id: helper_count
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom; bottomMargin: vpx(6)
            }
            text: (currentGameIndex + 1)+"/"+gv_games.count
            color: "white"
            font {
                family: robotoSlabLight.name
                pixelSize: vpx(14)
            }

        }
    }

    // Bottons
    Row {
        anchors {
            bottom: parent.bottom; bottomMargin: vpx(15)
            left: parent.left
            leftMargin: parent.width * 0.05
        }
        spacing: vpx(20)

        Controls {
            id: button_R

            message: "GO <b>BACK</b>"

            text_color: "#E06C9A"
            front_color: "#26E06C9A"
            back_color: "#26E06C9A"
            input_button: "BTN-R"
        }

        Controls {
            id: button_L

            message: currentGame !== null && currentGame.favorite ? "REMOVE <b>FAVORITE</b>" : "ADD <b>FAVORITE</b>"

            text_color: "#F3C03B"
            front_color: "#26F3C03B"
            back_color: "#26F3C03B"
            input_button: "BTN-L"

            visible: currentGame !== null
        }

        Controls {
            id: button_U

            message: ( games.state === "all" ) ? "SHOW <b>ALL ·</b> FAVORITES" : "SHOW ALL <b>· FAVORITES</b>"

            text_color: "#66D2EC"
            front_color: "#2666D2EC"
            back_color: "#2666D2EC"
            input_button: "BTN-U"
        }
    }

}