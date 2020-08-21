import QtQuick 2.8
import QtMultimedia 5.9

import "Home"
import "Collections"
import "Menu"
import "Games"

FocusScope {
    id: root

    focus: true

    FontLoader { id: montserratMedium; source: "./assets/fonts/Montserrat-Medium.ttf" }
    FontLoader { id: montserratBold; source: "./assets/fonts/Montserrat-Bold.ttf" }
    FontLoader { id: robotoSlabLight; source: "./assets/fonts/RobotoSlab-Light.ttf" }
    FontLoader { id: robotoSlabThin; source: "./assets/fonts/RobotoSlab-Thin.ttf" }
    FontLoader { id: robotoSlabRegular; source: "./assets/fonts/RobotoSlab-Regular.ttf" }

    // [0] = HOME
    // [1] = COLLECTIONS
    // [2] = GAMES
    property int currentMenuIndex: api.memory.get("currentMenuIndex") || 0
    property int currentCollectionIndex: api.memory.get("currentCollectionIndex") || 0
    property var currentCollection: api.collections.get(currentCollectionIndex)

    property variant dataMenu: [
        { name: "home" },
        { name: "collections" },
        { name: "games" }
    ]

    // property variant dataStates: {
    //     "gameList":         { xPosition: -root.width *2 },
    //     "collectionsPage":  { xPosition: -root.width },
    //     "home_lastPlayed":  { xPosition: 0 },
    //     "home_favorites":   { xPosition: 0 }
    // }

    property variant dataManufacturers: {
        "sega":     { color: "#17569b" },
        "sony":     { color: "#1D1D1D" },
        "snk":      { color: "#359CD2" },
        "nec":      { color: "#2E1D81" },
        "nintendo": { color: "#E11919" },
        "various":  { color: "#18A46E" },
        "valve":    { color: "#010314" }
    }

    // Additional data to display manufacturers and release dates
    property variant dataConsoles: {
        "arcade":       { manufacturer: "various",  release: "1971", color: "#D00E2D", altColor: "#9B071E" },
        "gamegear":     { manufacturer: "sega",     release: "1990", color: "#0D1114", altColor: "#1F1F1F" },
        "gb":           { manufacturer: "nintendo", release: "1989", color: "#031268", altColor: "#010D50" },
        "gba":          { manufacturer: "nintendo", release: "2001", color: "#1E02B4", altColor: "#19077C" },
        "gbc":          { manufacturer: "nintendo", release: "1998", color: "#997F03", altColor: "#725E00" },
        "gc":           { manufacturer: "nintendo", release: "2001", color: "#441BA3", altColor: "#24066A" },
        "mastersystem": { manufacturer: "sega",     release: "1985", color: "#A71010", altColor: "#790303" },
        "megadrive":    { manufacturer: "sega",     release: "1988", color: "#230000", altColor: "#180000" },
        "genesis":      { manufacturer: "sega",     release: "1988", color: "#230000", altColor: "#180000" },
        "n64":          { manufacturer: "nintendo", release: "1996", color: "#45832D", altColor: "#356F20" },
        "nds":          { manufacturer: "nintendo", release: "2004", color: "#B4B4B4", altColor: "#363636" },
        "neogeo":       { manufacturer: "snk",      release: "1990", color: "#08B5D5", altColor: "#008199" },
        "nes":          { manufacturer: "nintendo", release: "1983", color: "#272727", altColor: "#656565" },
        "ngp":          { manufacturer: "snk",      release: "1998", color: "#93192D", altColor: "#6B0909" },
        "ngpc":         { manufacturer: "snk",      release: "1999", color: "#460674", altColor: "#5C056B" },
        "pcengine":     { manufacturer: "nec",      release: "1987", color: "#96040C", altColor: "#7E040B" },
        "psp":          { manufacturer: "sony",     release: "2004", color: "#050C10", altColor: "#6A818C" },
        "psx":          { manufacturer: "sony",     release: "1994", color: "#D9BE36", altColor: "#252525" },
        "saturn":       { manufacturer: "sega",     release: "1994", color: "#3B3A9C", altColor: "#292885" },
        "dreamcast":    { manufacturer: "sega",     release: "1998", color: "#FB7A33", altColor: "#C0571C" },
        "segacd":       { manufacturer: "sega",     release: "1991", color: "#010314", altColor: "#02062B" },
        "snes":         { manufacturer: "nintendo", release: "1990", color: "#84E8A7", altColor: "#65A57B" },
        "wii":          { manufacturer: "nintendo", release: "2006", color: "#75C4D4", altColor: "#D2EBF0" },
        "steam":        { manufacturer: "valve",    release: "2003", color: "#010314", altColor: "#252525" }
    }

    // state: api.memory.get("currentPageState") || "home_lastPlayed"
    state: dataMenu[currentMenuIndex].name

    transitions: [
        Transition {
            from: "home"
            to: "collections"
            PropertyAnimation {
                target: home;
                property: "x";
                from: 0;
                to: -root.width;
                duration: 150
            }
            PropertyAnimation {
                target: collections;
                property: "x";
                from: root.width;
                to: 0;
                duration: 150
            }
        },
        Transition {
            from: "collections"
            to: "home"
            PropertyAnimation {
                target: home;
                property: "x";
                from: -root.width;
                to: 0;
                duration: 150
            }
            PropertyAnimation {
                target: collections;
                property: "x";
                from: 0;
                to: root.width;
                duration: 150
            }
        },
        Transition {
            from: "collections"
            to: "games"
            PropertyAnimation {
                target: collections;
                property: "x";
                from: 0;
                to: -root.width;
                duration: 150
            }
            PropertyAnimation {
                target: games;
                property: "x";
                from: root.width;
                to: 0;
                duration: 150
            }
        },
        Transition {
            from: "games"
            to: "collections"
            PropertyAnimation {
                target: collections;
                property: "x";
                from: -root.width;
                to: 0;
                duration: 150
            }
            PropertyAnimation {
                target: games;
                property: "x";
                from: 0;
                to: root.width;
                duration: 150
            }
        }
    ]


    Rectangle {
        id: rect_main
        width: parent.width
        height: parent.height
        color: "white"

    }

    Home {
        id: home
        width: root.width
        height: root.height * 0.9
        anchors.bottom: root.bottom
        focus: ( root.state === "home" )
        opacity: focus
        visible: opacity
    }

    Collections {
        id: collections
        width: root.width
        height: root.height
        focus: ( root.state === "collections" )
        opacity: focus
        visible: opacity
    }

    Games {
        id: games
        width: root.width
        height: root.height * 0.9
        anchors.bottom: root.bottom
        focus: ( root.state === "games" )
        opacity: focus
        visible: opacity
    }

    Menu {
        id: menu
        width: root.width
        height: root.height * 0.1
        anchors {
            top: root.top
        }
        focus: true
    }
    
    Keys.onPressed: {
        if (api.keys.isPrevPage(event)) {
            event.accepted = true;
            if (currentMenuIndex > 0)
                currentMenuIndex--
        }

        if (api.keys.isNextPage(event)) {
            event.accepted = true;
            if (currentMenuIndex < (dataMenu.length - 1))
                currentMenuIndex++
        }
    }

    // SoundEffect {
    //     id: sfxFlip
    //     source: "assets/sounds/flip_card.wav"
    //     volume: 0.5
    // }

}