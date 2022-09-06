import QtQuick 2.15
import QtGraphicalEffects 1.12
import SortFilterProxyModel 0.2
import QtMultimedia 5.15
import "qrc:/qmlutils" as PegasusUtils
import "../Global"
import "../Filter"

FocusScope {
    property int sortIndex: api.memory.get('sortIndex') || 0
    readonly property var sortFields: ['sortTitle', 'release', 'rating', 'genre', 'lastPlayed', 'favorite']
    readonly property var sortLabels: {'sortTitle':'Title', 'release':'Release Date', 'rating':'Rating', 'genre':'Genre', 'lastPlayed':'Last Played', 'favorite':'Favorite'}
    readonly property string sortField: sortFields[sortIndex]
    readonly property string collectionType: currentCollection.extra.collectiontype !== undefined ? currentCollection.extra.collectiontype.toString() : 'System'
    readonly property var customSortCategories: ['Custom', 'Series']
    readonly property var customSystemLogoCategories: ['Custom', 'Series']
    readonly property bool customCollection: customSystemLogoCategories.includes(collectionType)
    readonly property string systemName: (currentGame !== null && dataConsoles[currentGame.extra.system] !== undefined) ? dataConsoles[currentGame.extra.system].fullName : ""

    property string clearedShortname: clearShortname(currentCollection.shortName)
    readonly property string alt_color2: (dataConsoles[clearedShortname] !== undefined) ? dataConsoles[clearedShortname].altColor2 : dataConsoles["default"].altColor2

    readonly property string alt_colorBright: (dataConsoles[clearedShortname] !== undefined) ? dataConsoles[clearedShortname].altColor : dataConsoles["default"].altColor
    readonly property string alt_colorDimm: alt_colorBright.replace(/#/g, "#56");
    readonly property string alt_color: {
        if (gridVR >= 3) {
            return accentColor == "bright" ? alt_colorBright : alt_colorDimm
        } else {
            return colorScheme[theme].secondary
        }
    }
    readonly property string alt_colorShadow: {
        if (gridVR >= 3) {
            return accentColor == "bright" ? lightenDarkenColor(alt_colorBright, -5) : lightenDarkenColor(alt_colorBright, -5).replace(/#/g, "#56");
        } else {
            return lightenDarkenColor(colorScheme[theme].secondary, -5)
        }
    }
    readonly property string touch_colorBright: (dataConsoles[clearedShortname] !== undefined) ? dataConsoles[clearedShortname].color : dataConsoles["default"].color
    readonly property string touch_colorDimm: touch_colorBright.replace(/#/g, "#56");
    readonly property string touch_color: (accentColor == "bright") ? touch_colorBright : touch_colorDimm

    readonly property string text_color: {
        if ((accentColor == "bright") && (gridVR >= 3)) {
            return lightOrDark(touch_color) === "light" ? colorScheme[theme].textdark : colorScheme[theme].textlight
        } else {
            return colorScheme[theme].text
        }
    }

    property int currentGameIndex: 0
    property var currentGame: {
        if (gv_games.count === 0)
            return null;
        return findCurrentGameFromProxy(currentGameIndex, currentCollection);
    }

    property int gridVR: {
        if (gamesGridVR ===  "dynamic")
            return Math.min(Math.max(parseInt((gv_games.count + 10) / 20), 1), 5);
        else return  gamesGridVR
    }

    focus: games.focus
    state: {
        if (!filter.withMultiplayer && !filter.withFavorite && !filter.withTitle)
            return "unfiltered"
        else return "filtered"
    }

    SortFilterProxyModel {
        id: filteredGames
        sourceModel: currentCollection.games
        filters: [
            RegExpFilter {
                roleName: "title"
                pattern: filter.withTitle
                caseSensitivity: Qt.CaseInsensitive
                enabled: filter.withTitle
            },
            RangeFilter {
                roleName: "players"
                minimumValue: 2
                enabled: filter.withMultiplayer
            },
            ValueFilter {
                roleName: "favorite"
                value: true
                enabled: filter.withFavorite
            }
        ]
        sorters: [
            RoleSorter {
                roleName: sortField
                sortOrder: sortField == 'rating' || sortField == 'lastPlayed' || sortField == 'favorite' ? Qt.DescendingOrder : Qt.AscendingOrder
                enabled: !customSortCategories.includes(collectionType) && currentCollection.shortName !== 'lastplayed' && root.state === "games"
            },
            ExpressionSorter {
                expression: {
                    if (!customSortCategories.includes(collectionType)) {
                        return true;
                    }

                    var sortLeft = getCollectionSortValue(modelLeft, currentCollection.shortName);
                    var sortRight = getCollectionSortValue(modelRight, currentCollection.shortName);
                    return (sortLeft < sortRight);
                }
                enabled: customSortCategories.includes(collectionType) && root.state === "games"
            }
        ]
    }

    Behavior on focus {
        ParallelAnimation {
            PropertyAnimation {
                target: skew_color
                property: "anchors.leftMargin"
                from: parent.width * 0.97
                to: parent.width * 0.725
                duration: 250
            }
        }
    }

    // Background image
    BackgroundImage {
        id: backgroundimage
        game: currentGame
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }
        opacity: 0.255
        visible: gamesBGImg != "1"
    }

    // Skewed background
    Rectangle {
        id: skew_color
        width: parent.width * 0.42
        height: parent.height
        antialiasing: true
        anchors {
            left: parent.left
            leftMargin: parent.width * 0.725
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

    // Content
    Item {
        width: parent.width * 0.90
        anchors {
            top: parent.top
            bottom: parent.bottom
            bottomMargin: vpx(30)
            horizontalCenter: parent.horizontalCenter
        }

        // Game details
        Item {
            id: item_game_details
            width: parent.width * 0.95
            height: parent.height * 0.5
            anchors {
                top: parent.top
                right: parent.right
            }

            Item {
                anchors.fill: parent

                // All game information
                Component {
                    id: cpnt_gameList_details

                    Item {
                        readonly property var currentGameGenre: currentGame.genre.split(" / ") || ""
                        anchors.fill: parent

                        // RELEASE DATE
                        Text {
                            id: txt_releaseYear
                            anchors {
                                top: parent.top
                                topMargin: -vpx(20)
                                right: parent.right
                            }

                            text: currentGame.releaseYear || dataText[lang].games_na
                            font {
                                family: global.fonts.sans
                                weight: Font.Black
                                italic: true
                                pixelSize: vpx(140)
                            }
                            color: alt_color
                            layer.enabled: true
                            layer.effect: DropShadow {
                                spread: 1.0
                                verticalOffset: 5
                                horizontalOffset: 5
                                color: alt_colorShadow
                                radius: 5
                                samples: 11
                            }

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
                                color: text_color
                            }

                            Row {
                                spacing: vpx(5)

                                Text {
                                    text: dataText[lang].games_developedBy
                                    font {
                                        family: global.fonts.sans
                                        weight: Font.Light
                                        italic: true
                                        pixelSize: vpx(14 * fontScalingFactor)
                                    }
                                    color: text_color
                                }

                                Text {
                                    text: currentGame.developer
                                    font {
                                        family: global.fonts.sans
                                        weight: Font.Medium
                                        pixelSize: vpx(14 * fontScalingFactor)
                                    }
                                    color: text_color
                                }

                                Text {
                                    text: dataText[lang].games_for
                                    font {
                                        family: global.fonts.sans
                                        weight: Font.Light
                                        italic: true
                                        pixelSize: vpx(14)
                                    }
                                    color: text_color
                                    visible: customCollection && systemName !== ""
                                }

                                Text {
                                    text: systemName
                                    font {
                                        family: global.fonts.sans
                                        weight: Font.Medium
                                        pixelSize: vpx(14)
                                    }
                                    color: text_color
                                    visible: customCollection && systemName !== ""
                                }
                            }

                            Row {
                                spacing: vpx(5)
                                // RATING
                                RatingStars {
                                    readonly property double rating: (currentGame.rating * 5).toFixed(1)
                                }
                            }

                            Row {
                                spacing: vpx(10)

                                Rectangle {
                                    width: txt_players.contentWidth + vpx(20)
                                    height: txt_players.contentHeight + vpx(10)
                                    color: colorScheme[theme].secondary
                                    border {
                                        width: vpx(1)
                                        color: colorScheme[theme].secondary
                                    }

                                    Text {
                                        id: txt_players
                                        property string convertPlayer: currentGame.players > 1 ? "1-" + currentGame.players + " " + dataText[lang].games_players : dataText[lang].games_player
                                        anchors.centerIn: parent
                                        text: convertPlayer
                                        font {
                                            family: global.fonts.sans
                                            weight: Font.Black
                                            pixelSize: vpx(12 * fontScalingFactor)
                                        }
                                        color: colorScheme[theme].text
                                    }
                                }

                                Rectangle {
                                    width: txt_favorited.contentWidth + vpx(20)
                                    height: txt_favorited.contentHeight + vpx(10)
                                    color: colorScheme[theme].favorite.replace(/#/g, "#33");

                                    Text {
                                        id: txt_favorited
                                        anchors.centerIn: parent
                                        text: dataText[lang].games_favorited
                                        font {
                                            family: global.fonts.sans
                                            weight: Font.Black
                                            pixelSize: vpx(12 * fontScalingFactor)
                                        }
                                        color: colorScheme[theme].favorite
                                    }
                                    visible: currentGame.favorite
                                }

                                Repeater {
                                    model: currentGameGenre
                                    delegate: Rectangle {
                                        width: txt_genre.contentWidth + vpx(20)
                                        height: txt_genre.contentHeight + vpx(10)
                                        color: colorScheme[theme].secondary
                                        border {
                                            width: vpx(1)
                                            color: colorScheme[theme].secondary
                                        }

                                        Text {
                                            id: txt_genre
                                            anchors.centerIn: parent
                                            text: modelData
                                            font {
                                                family: global.fonts.sans
                                                weight: Font.Medium
                                                pixelSize: vpx(12 * fontScalingFactor)
                                            }
                                            color: colorScheme[theme].text
                                        }
                                        visible: (modelData !== "")
                                    }
                                }

                                // Arcade Port
                                Rectangle {
                                    width: txt_arcadeport.contentWidth + vpx(20)
                                    height: txt_arcadeport.contentHeight + vpx(10)
                                    color: alt_color2
                                    border {
                                        width: vpx(1)
                                        color: alt_color2
                                    }

                                    Text {
                                        id: txt_arcadeport
                                        anchors.centerIn: parent
                                        text: dataText[lang].games_arcadeport
                                        font {
                                            family: global.fonts.sans
                                            weight: Font.Medium
                                            pixelSize: vpx(12)
                                        }
                                        color: lightOrDark(alt_color2) === "light" ? colorScheme[theme].textdark : colorScheme[theme].textlight
                                    }
                                    visible: (currentGame.extra.arcadeport !== undefined) && (currentGame.extra.arcadeport.toString() === 'True')
                                }
                            }

                            // Description
                            Item {
                                width: parent.width
                                height: vpx(100)

                                PegasusUtils.AutoScroll {
                                    anchors.fill: parent
                                    Text {
                                        id: txt_game_description
                                        width: parent.width
                                        text: (currentGame.description || currentGame.summary) ? (currentGame.description || currentGame.summary) : dataText[lang].games_withoutDescription
                                        font {
                                            family: global.fonts.condensed
                                            weight: Font.Light
                                            pixelSize: vpx(14 * fontScalingFactor)
                                        }
                                        wrapMode: Text.WordWrap
                                        elide: Text.ElideRight
                                        horizontalAlignment: Text.AlignJustify
                                        color: text_color
                                    }
                                }
                            }
                        }
                    }
                }

                Loader {
                    id: loader_gameList_details
                    width: {
                        if (gridVR >= 3)
                            parent.width * 0.31
                        else parent.width * 0.67
                    }
                    height: {
                        if (gridVR >= 3)
                            parent.height * 0.95
                        else parent.height
                    }

                    anchors {
                        top: {
                            if (gridVR >= 3)
                                parent.bottom
                            else parent.top
                        }
                        right: {
                            if (gridVR >= 3)
                                parent.right
                        }
                        left: {
                            if (gridVR < 3)
                                parent.left
                        }
                    }
                    asynchronous: true
                    sourceComponent: cpnt_gameList_details
                    active: games.focus && currentGame !== null
                    visible: status === Loader.Ready
                }
                Item {
                    width: parent.width * 0.31
                    height: {
                        if ((gridVR >= 3) && (fontScalingFactor > 1.1))
                            parent.height * 0.75
                        else parent.height * 0.9
                    }
                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }
                    Loader {
                        id: loader_top_video
                        anchors.fill: parent

                        asynchronous: true
                        sourceComponent: GameItemTopVideo {}
                        active: games.focus && gamesLayout === "BoxArt-Grid"
                        visible: status === Loader.Ready
                    }
                    Loader {
                        id: loader_top_boxart
                        anchors.fill: parent

                        asynchronous: true
                        sourceComponent: GameItemTopBoxFront {}
                        active: games.focus && gamesLayout === "Screenshot-Grid"
                        visible: status === Loader.Ready
                    }
                }

            }

            visible: currentGame !== null
        }

        // No games found
        Item {
            anchors.centerIn: parent
            visible: currentGame === null && (games.state === "filtered")
            Rectangle {
                Text {
                    anchors.centerIn: parent
                    text: dataText[lang].global_noFilteredGames
                    color: colorScheme[theme].accentalt
                    font {
                        family: robotoSlabRegular.name
                        pixelSize: vpx(42 * fontScalingFactor)
                    }
                }
            }
        }

        // Games
        Item {
            id: games_bottom
            width: {
                if (gridVR >= 3)
                    parent.width * 0.65
                else parent.width
            }
            height: {
                if (gridVR >= 3)
                    parent.height * 0.9
                else parent.height * 0.5
            }
            anchors {
                bottom: parent.bottom
            }

            GridView {
                id: gv_games
                width: parent.width
                height: parent.height * 0.85
                cellWidth: width / gamesGridIPR
                cellHeight: height / gridVR
                anchors.horizontalCenter: parent.horizontalCenter

                clip: true

                preferredHighlightBegin: height
                preferredHighlightEnd: height * 0.5

                currentIndex: currentGameIndex
                onCurrentIndexChanged: currentGameIndex = currentIndex

                model: filteredGames
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
                            color: colorScheme[theme].background
                            visible: !loader_gameList_boxart.visible && !loader_gameList_screenshot.visible 
                        }

                        Loader {
                            id: loader_gameList_boxart
                            anchors.fill: parent

                            asynchronous: true
                            sourceComponent: GameItemGridBoxFront {}
                            active: games.focus && gamesLayout === "BoxArt-Grid"
                            visible: status === Loader.Ready
                        }
                        Loader {
                            id: loader_gameList_screenshot
                            anchors.fill: parent

                            asynchronous: true
                            sourceComponent: GameItemGridScreenshot {selected: GridView.isCurrentItem}
                            active: games.focus && gamesLayout === "Screenshot-Grid"
                            visible: status === Loader.Ready
                        }
                    }
                }

                highlightRangeMode: GridView.StrictlyEnforceRange
                snapMode: GridView.SnapToRow
                highlightFollowsCurrentItem: true

                focus: games.focus

                Component.onCompleted: {
                    currentGameIndex = api.memory.get(collectionType + "-" + currentCollectionIndex + "-currentGameIndex") || 0
                    positionViewAtIndex(currentGameIndex, GridView.SnapPosition);
                    api.memory.unset(collectionType + "-" + currentCollectionIndex + "-currentGameIndex");
                }

                Keys.onPressed: {
                    if (event.isAutoRepeat) {
                        return;
                    }

                    if (api.keys.isAccept(event)) {
                        event.accepted = true;
                        playPlaySound();
                        if (currentGame !== null) {
                            saveCurrentState(currentGameIndex, sortIndex);
                            currentGame.launch();
                        }
                    }

                    if (api.keys.isFilters(event)) {
                        event.accepted = true;
                        playBackSound();
                        filter.focus = true;
                        return;
                    }

                    if (api.keys.isCancel(event)) {
                        event.accepted = true;
                        playBackSound();
                        currentMenuIndex = 2;
                        return;
                    }

                    if (api.keys.isDetails(event)) {
                        event.accepted = true;
                        if (currentGame !== null) {
                            currentGame.favorite = !currentGame.favorite;
                        }
                    }

                    // Select button triggers sort by category - not sure what enum matches so just using the INT value for the key
                    if (event.key == 1048586) {
                        event.accepted = true;
                        playBackSound();
                        sortIndex = (sortIndex + 1) % sortFields.length;
                        return;
                    }

                    if (event.key == Qt.Key_Left) {
                        playNavSound();
                    }

                    if (event.key == Qt.Key_Right) {
                        playNavSound();
                    }

                    if (event.key == Qt.Key_Down) {
                        playNavSound();
                    }

                    if (event.key == Qt.Key_Up) {
                        playNavSound();
                    }
                }

                Keys.onReleased: {
                    if (api.keys.isPageDown(event) && gamesPgUpDownFunction === 'Games') {
                        event.accepted = true;
                        var jumpCount = gridVR * gamesGridIPR;
                        if ((currentGameIndex + jumpCount) > currentCollection.games.count - 1) {
                            currentGameIndex = currentCollection.games.count - 1;
                        } else {
                            currentGameIndex += jumpCount;
                        }
                        return;
                    }

                    if (api.keys.isPageUp(event) && gamesPgUpDownFunction === 'Games') {
                        event.accepted = true;
                        var jumpCount = gridVR * gamesGridIPR;
                        if ((currentGameIndex - jumpCount) < 0) {
                            currentGameIndex = 0;
                        } else {
                            currentGameIndex -= jumpCount;
                        }
                        return;
                    }

                    if (event.isAutoRepeat) {
                        return;
                    }

                    if (api.keys.isPageDown(event) && gamesPgUpDownFunction === 'Collections') {
                        event.accepted = true;
                        playCollectionSound();
                        if (currentCollectionIndex >= allCollections.length - 1) {
                            currentCollectionIndex = 0;
                        } else {
                            currentCollectionIndex++;
                        }
                        saveCurrentCollectionState(collectionType, currentCollectionIndex);
                        currentGameIndex = 0;
                        return;
                    }

                    if (api.keys.isPageUp(event) && gamesPgUpDownFunction === 'Collections') {
                        event.accepted = true;
                        playCollection2Sound();
                        if (currentCollectionIndex <= 0) {
                            currentCollectionIndex = allCollections.length - 1;
                        } else {
                            currentCollectionIndex--;
                        }
                        saveCurrentCollectionState(collectionType, currentCollectionIndex);
                        currentGameIndex = 0;
                        return;
                    }
                }

            }

            // Navigation bar
            Component {
                id: cpnt_helper_nav
                Item {
                    Rectangle {
                        property int heightBar: parent.height - vpx(50)
                        anchors {
                            left: parent.left
                            leftMargin: parent.width + 30
                            top: parent.top
                            topMargin: vpx(6)
                        }
                        width: vpx(2)
                        height: heightBar * ( (currentGameIndex + 1) / gv_games.count )
                        color: colorScheme[theme].accent
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

        // Bottom (buttons and counter)
        Item {
            width: parent.width
            height: vpx(30)
            anchors.bottom: parent.bottom

            Row {
                visible: osc === 0
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }
                spacing: vpx(20)

                Controls {
                    id: button_R

                    message: dataText[lang].global_back

                    text_color: colorScheme[theme].cancel
                    front_color: colorScheme[theme].cancel.replace(/#/g, "#26");
                    back_color: colorScheme[theme].cancel.replace(/#/g, "#26");
                    input_button: osdScheme[controlScheme].BTNR
                }

                Controls {
                    id: button_U

                    message: {
                        if (games.state === "filtered")
                            return dataText[lang].games_filtered 
                        return dataText[lang].games_filter
                    }
                    text_color: colorScheme[theme].filters
                    front_color: colorScheme[theme].filters.replace(/#/g, "#26");
                    back_color: colorScheme[theme].filters.replace(/#/g, "#26");
                    input_button: osdScheme[controlScheme].BTNU
                }

                Controls {
                    id: button_L

                    message: currentGame !== null && currentGame.favorite ? dataText[lang].games_removeFavorite : dataText[lang].games_addFavorite

                    text_color: colorScheme[theme].details
                    front_color: colorScheme[theme].details.replace(/#/g, "#26");
                    back_color: colorScheme[theme].details.replace(/#/g, "#26");
                    input_button: osdScheme[controlScheme].BTNL

                    visible: currentGame !== null
                }

                Controls {
                    id: button_Back

                    message: dataText[lang].games_sortedBy + " <b>" + getSortLabel() + "</b>";

                    text_color: colorScheme[theme].sorters
                    front_color: colorScheme[theme].sorters.replace(/#/g, "#26");
                    back_color: colorScheme[theme].sorters.replace(/#/g, "#26");
                    input_button: osdScheme[controlScheme].BTNSelect
                }

            }

            Text {
                id: helper_count
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right;
                }
                text: (currentGameIndex + 1) + "/" + gv_games.count
                color: text_color
                font {
                    family: robotoSlabLight.name
                    pixelSize: vpx(14 * fontScalingFactor)
                }
            }

            FilterLayer {
                id: filter
                anchors.fill: parent
                onCloseRequested: gv_games.focus = true
            }

        }
    }

    function findCurrentGameFromProxy(idx, collection) {
        // Last Played collection uses 2 filters chained together
        if (collection.shortName == "lastplayed") {
            return api.allGames.get(lastPlayedBase.mapToSource(idx));
        } else if (collection.shortName == "favorites") {
            return api.allGames.get(allFavorites.mapToSource(idx));
        } else {
            return currentCollection.games.get(filteredGames.mapToSource(idx))
        }
    }

    function getCollectionSortValue(gameData, collName) {
        return gameData.extra['customsort-' + collName] !== undefined ? gameData.extra['customsort-' + collName] : "";
    }

    function getSortLabel() {
        if (currentCollection.shortName == 'lastplayed') {
            return 'Last Played';
        } else if (customSortCategories.includes(collectionType)) {
            return 'Custom';
        } else {
            return sortLabels[sortField];
        }
    }

}