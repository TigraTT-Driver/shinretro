import QtQuick 2.15
import QtGraphicalEffects 1.12
import QtMultimedia 5.15
import QtQml.Models 2.15
import SortFilterProxyModel 0.2

import "Home"
import "Collections"
import "Menu"
import "Games"
import "Settings"

FocusScope {
    id: root

    focus: true

    FontLoader { id: montserratMedium; source: "./assets/fonts/Montserrat-Medium.ttf" }
    FontLoader { id: montserratBold; source: "./assets/fonts/Montserrat-Bold.ttf" }
    FontLoader { id: robotoSlabLight; source: "./assets/fonts/RobotoSlab-Light.ttf" }
    FontLoader { id: robotoSlabThin; source: "./assets/fonts/RobotoSlab-Thin.ttf" }
    FontLoader { id: robotoSlabRegular; source: "./assets/fonts/RobotoSlab-Regular.ttf" }

    // Color schemes
    property var themeDark: {
        return {
            main: "#202335",
            secondary: "#1C1E2E",
            background: "#25283b",
            text: "white",
            textalt: "#414767",
            accent: "#757BA0",
            accentalt:"#7981A8",
            icons: "white",
            favorite: "#F3C03B",
            accepted: "#8E63EC",
            cancel: "#E06C9A",
            details: "#F3C03B",
            filters: "#66D2EC"
        }
    }

    property var themeLight: {
        return {
            main: "white",
            secondary: "#EBEBEB",
            background: "white",
            text: "black",
            textalt: "#2C2C2C",
            accent: "#10AEBE",
            accentalt:"#2D2D2D",
            icons: "black",
            favorite: "#cc8f00",
            accepted: "#00991E",
            cancel: "#E6140D",
            details: "#1C2C98",
            filters: "#996b00"
        }
    }

    // Load settings
    property var theme : api.memory.get('theme') === 'themeLight' ? themeLight : themeDark
    property var logoVariant : api.memory.get('logoVariant') || "mono"
    property var controlScheme : api.memory.get('controlScheme') || "Universal"
    property var osc : api.memory.get('osc') || "No"
    property var mutesfx : {
        if (api.memory.get('mutesfx') == "Yes") {
            return "0.0";
        } else {
            return "1.0";
        }
    }
    property var homeVideo : api.memory.get('homeVideo') || "Yes"
    property var homeVideoMute : {
        if (api.memory.get('homeVideoMute') == "Yes") {
            return true;
        } else {
            return false;
        }
    }
    property var accentColor : api.memory.get('accentColor') || "dimm"
    property var allGamesCollection : api.memory.get('allGamesCollection') || "Yes"
    property var gamesVideo : api.memory.get('gamesVideo') || "Yes"
    property var gamesVideoMute : {
        if (api.memory.get('gamesVideoMute') == "Yes") {
            return true;
        } else {
            return false;
        }
    }

    // [0] = Settings
    // [1] = HOME
    // [2] = COLLECTIONS
    // [3] = GAMES

    property int currentMenuIndex: api.memory.get("currentMenuIndex") || 1

    // List of game collections
    property var allCollections: {
        const collections = api.collections.toVarArray()
        if (allGamesCollection != "No") {
            collections.unshift({"name": "All", "shortName": "all", "games": api.allGames})
        }
        return collections
    }

    property int currentCollectionIndex: api.memory.get("currentCollectionIndex") || 0
    property var currentCollection: allCollections[currentCollectionIndex]

    property variant dataMenu: [
        { name: "settings", title: "settings"},
        { name: "home", title: "home"},
        { name: "collections", title: "collections"},
        { name: "games", title: "games"}
    ]

    function clearShortname(shortname) {
        return dataLaunchbox[shortname] ? dataLaunchbox[shortname] : shortname
    }

    property variant dataLaunchbox: {
        "amstrad cpc" :                             "amstradcpc",
        "apple ii" :                                "apple2",
        "atari 2600" :                              "atari2600",
        "atari 5200" :                              "atari5200",
        "atari st" :                                "atarist",
        "atari 7800" :                              "atari7800",
        "atari lynx" :                              "atarilynx",
        "atari jaguar" :                            "atarijaguar",
        "capcom cps1" :                             "cps1",
        "capcom cps2" :                             "cps2",
        "capcom cps3" :                             "cps3",
        "commodore 64" :                            "c64",
        "commodore amiga" :                         "amiga",
        "mattel intellivision" :                    "intellivision",
        "microsoft msx" :                           "msx",
        "microsoft msx2" :                          "msx2",
        "nec turbografx-16" :                       "turbografx16",
        "pc engine supergrafx" :                    "supergrafx",
        "nec pc-fx" :                               "pcfx",
        "nintendo entertainment system" :           "nes",
        "nintendo famicom disk system" :            "fds",
        "nintendo game boy" :                       "gb",
        "super nintendo entertainment system" :     "snes",
        "nintendo 64" :                             "n64",
        "nintendo game boy color" :                 "gbc",
        "nintendo game boy advance" :               "gba",
        "nintendo gamecube" :                       "gc",
        "nintendo ds" :                             "nds",
        "nintendo wii" :                            "wii",
        "nintendo 3ds" :                            "3ds",
        "nintendo wii u" :                          "wiiu",
        "3do interactive multiplayer" :             "3do",
        "sammy atomiswave" :                        "atomiswave",
        "sega master system" :                      "mastersystem",
        "sega genesis" :                            "genesis",
        "sega mega drive" :                         "megadrive",
        "sega game gear" :                          "gamegear",
        "sega cd" :                                 "segacd",
        "sega 32x" :                                "sega32x",
        "sega saturn" :                             "saturn",
        "sega dreamcast" :                          "dreamcast",
        "sega sg-1000" :                            "sg1000",
        "sinclair zx spectrum" :                    "zxspectrum",
        "gce vectrex" :                             "vectrex",
        "snk neo geo aes" :                         "neogeo",
        "snk neo geo mvs":                          "neogeo",
        "snk neo geo cd" :                          "neogeocd",
        "snk neo geo pocket" :                      "ngp",
        "snk neo geo pocket color" :                "ngpc",
        "sony playstation" :                        "psx",
        "sony playstation 2" :                      "ps2",
        "sony psp" :                                "psp",
        "final burn alpha" :                        "fba",
        "final burn neo" :                          "fbneo"
    }

    // Additional data to display manufacturers and release dates
    property variant dataConsoles: {
        "apple2":           { manufacturer: "apple",                release: "1977",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "amstradcpc":       { manufacturer: "amstrad",              release: "1984",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "atari2600":        { manufacturer: "atari",                release: "1977",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "atari5200":        { manufacturer: "atari",                release: "1982",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "atarist":          { manufacturer: "atari",                release: "1985",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "atari7800":        { manufacturer: "atari",                release: "1986",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "atarilynx":        { manufacturer: "atari",                release: "1989",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "atarijaguar":      { manufacturer: "atari",                release: "1993",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "cps1":             { manufacturer: "capcom",               release: "1988",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "cps2":             { manufacturer: "capcom",               release: "1993",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "cps3":             { manufacturer: "capcom",               release: "1996",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "colecovision":     { manufacturer: "coleco",               release: "1982",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "c64":              { manufacturer: "commodore",            release: "1982",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "amiga":            { manufacturer: "commodore",            release: "1985",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "intellivision":    { manufacturer: "mattel",               release: "1979",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "msx":              { manufacturer: "microsoft",            release: "1983",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "msx2":             { manufacturer: "microsoft",            release: "1985",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "pcengine":         { manufacturer: "nec",                  release: "1987",    color: "#2696040C", altColor: "#7E040B",    colorBright: "#96040C", altColorBright: "#7E040B" },
        "turbografx16":     { manufacturer: "nec",                  release: "1987",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "supergrafx":       { manufacturer: "nec",                  release: "1989",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "pcfx":             { manufacturer: "nec",                  release: "1994",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "nes":              { manufacturer: "nintendo",             release: "1983",    color: "#26EFA053", altColor: "#EFA053",    colorBright: "#272727", altColorBright: "#656565" },
        "fds":              { manufacturer: "nintendo",             release: "1986",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "gb":               { manufacturer: "nintendo",             release: "1989",    color: "#26031268", altColor: "#010D50",    colorBright: "#031268", altColorBright: "#010D50" },
        "snes":             { manufacturer: "nintendo",             release: "1990",    color: "#2666D2EC", altColor: "#66D2EC",    colorBright: "#84E8A7", altColorBright: "#65A57B" },
        "n64":              { manufacturer: "nintendo",             release: "1996",    color: "#268E63EC", altColor: "#8E63EC",    colorBright: "#45832D", altColorBright: "#356F20" },
        "gbc":              { manufacturer: "nintendo",             release: "1998",    color: "#26997F03", altColor: "#725E00",    colorBright: "#997F03", altColorBright: "#725E00" },
        "gba":              { manufacturer: "nintendo",             release: "2001",    color: "#261E02B4", altColor: "#19077C",    colorBright: "#1E02B4", altColorBright: "#19077C" },
        "pokemini":         { manufacturer: "nintendo",             release: "2001",    color: "#26EFA053", altColor: "#EFA053",    colorBright: "#272727", altColorBright: "#656565" },        
        "gc":               { manufacturer: "nintendo",             release: "2001",    color: "#26441BA3", altColor: "#24066A",    colorBright: "#441BA3", altColorBright: "#24066A" },
        "nds":              { manufacturer: "nintendo",             release: "2004",    color: "#26B4B4B4", altColor: "#363636",    colorBright: "#B4B4B4", altColorBright: "#363636" },
        "wii":              { manufacturer: "nintendo",             release: "2006",    color: "#2675C4D4", altColor: "#D2EBF0",    colorBright: "#75C4D4", altColorBright: "#D2EBF0" },
        "wiiware":          { manufacturer: "nintendo",             release: "2008",    color: "#2675C4D4", altColor: "#D2EBF0",    colorBright: "#75C4D4", altColorBright: "#D2EBF0" },
        "3ds":              { manufacturer: "nintendo",             release: "2011",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "wiiu":             { manufacturer: "nintendo",             release: "2012",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "virtualboy":       { manufacturer: "nintendo",             release: "1995",    color: "#2696040C", altColor: "#7E040B",    colorBright: "#e60012", altColorBright: "#B10210" },
        "switch":           { manufacturer: "nintendo",             release: "2017",    color: "#26e60012", altColor: "#B10210",    colorBright: "#e60012", altColorBright: "#B10210" },
        "3do":              { manufacturer: "panasonic",            release: "1993",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "atomiswave":       { manufacturer: "sammy",                release: "2003",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "mastersystem":     { manufacturer: "sega",                 release: "1985",    color: "#26A71010", altColor: "#790303",    colorBright: "#A71010", altColorBright: "#790303" },
        "genesis":          { manufacturer: "sega",                 release: "1988",    color: "#26230000", altColor: "#180000",    colorBright: "#230000", altColorBright: "#180000" },
        "megadrive":        { manufacturer: "sega",                 release: "1988",    color: "#26230000", altColor: "#180000",    colorBright: "#230000", altColorBright: "#180000" },
        "gamegear":         { manufacturer: "sega",                 release: "1990",    color: "#260D1114", altColor: "#1F1F1F",    colorBright: "#0D1114", altColorBright: "#1F1F1F" },
        "segacd":           { manufacturer: "sega",                 release: "1991",    color: "#26010314", altColor: "#02062B",    colorBright: "#010314", altColorBright: "#02062B" },
        "sega32x":          { manufacturer: "sega",                 release: "1994",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "saturn":           { manufacturer: "sega",                 release: "1994",    color: "#263B3A9C", altColor: "#292885",    colorBright: "#3B3A9C", altColorBright: "#292885" },
        "dreamcast":        { manufacturer: "sega",                 release: "1998",    color: "#26FB7A33", altColor: "#C0571C",    colorBright: "#FB7A33", altColorBright: "#C0571C" },
        "sg1000":           { manufacturer: "sega",                 release: "1983",    color: "#262443AE", altColor: "#1D3792",    colorBright: "#A71010", altColorBright: "#790303" },
        "zxspectrum":       { manufacturer: "sinclair",             release: "1982",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "vectrex":          { manufacturer: "smith_engineering",    release: "1982",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "neogeo":           { manufacturer: "snk",                  release: "1990",    color: "#2608B5D5", altColor: "#008199",    colorBright: "#08B5D5", altColorBright: "#008199" },
        "neogeocd":         { manufacturer: "snk",                  release: "1994",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "ngp":              { manufacturer: "snk",                  release: "1998",    color: "#2693192D", altColor: "#6B0909",    colorBright: "#93192D", altColorBright: "#6B0909" },
        "ngpc":             { manufacturer: "snk",                  release: "1999",    color: "#26460674", altColor: "#5C056B",    colorBright: "#460674", altColorBright: "#5C056B" },
        "psx":              { manufacturer: "sony",                 release: "1994",    color: "#26D9BE36", altColor: "#252525",    colorBright: "#D9BE36", altColorBright: "#252525" },
        "ps2":              { manufacturer: "sony",                 release: "2000",    color: "#263144B1", altColor: "#00224C",    colorBright: "#3144B1", altColorBright: "#00224C" },
        "psp":              { manufacturer: "sony",                 release: "2004",    color: "#26050C10", altColor: "#6A818C",    colorBright: "#050C10", altColorBright: "#6A818C" },
        "ps3":              { manufacturer: "sony",                 release: "2006",    color: "#260D1114", altColor: "#1F1F1F",    colorBright: "#0D1114", altColorBright: "#1F1F1F" },
        "gog":              { manufacturer: "pc",                   release: "2008",    color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "ports":            { manufacturer: "pc",                   release: null,      color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "scummvm":          { manufacturer: "pc",                   release: null,      color: "#26997F03", altColor: "#725E00",    colorBright: "#997F03", altColorBright: "#725E00" },
        "steam":            { manufacturer: "valve",                release: "2003",    color: "#26010314", altColor: "#252525",    colorBright: "#010314", altColorBright: "#252525" },
        "arcade":           { manufacturer: "arcade",               release: null,      color: "#26D00E2D", altColor: "#9B071E",    colorBright: "#D00E2D", altColorBright: "#9B071E" },
        "all":              { manufacturer: null,                   release: null,      color: "#26FFD019", altColor: "#FF9919",    colorBright: "#FFD019", altColorBright: "#FF9919" },
        "daphne":           { manufacturer: "arcade",               release: null,      color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "fba":              { manufacturer: "arcade",               release: null,      color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "fbneo":            { manufacturer: "arcade",               release: null,      color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "mame":             { manufacturer: "arcade",               release: null,      color: "#26000000", altColor: "#252525",    colorBright: "#000000", altColorBright: "#252525" },
        "android":          { manufacturer: "OpenHandsetAlliance",  release: null,      color: "#2677c159", altColor: "#478230",    colorBright: "#77c159", altColorBright: "#478230" }
    }

    SortFilterProxyModel {
        id: allFavorites
        sourceModel: api.allGames
        filters: ValueFilter { roleName: "favorite"; value: true; }
    }

    // state: api.memory.get("currentPageState") || "home_lastPlayed"
    state: dataMenu[currentMenuIndex].name

    transitions: [
        Transition {
            from: "settings"
            to: "home"
            PropertyAnimation {
                target: settings;
                property: "x";
                from: 0;
                to: -root.width;
                duration: 150
            }
            PropertyAnimation {
                target: home;
                property: "x";
                from: root.width;
                to: 0;
                duration: 150
            }
        },
        Transition {
            from: "home"
            to: "settings"
            PropertyAnimation {
                target: settings;
                property: "x";
                from: -root.width;
                to: 0;
                duration: 150
            }
            PropertyAnimation {
                target: home;
                property: "x";
                from: 0;
                to: root.width;
                duration: 150
            }
        },
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
        color: theme.background
    }

    Settings {
        id: settings
        width: root.width
        height: root.height  * 0.9
        anchors.bottom: root.bottom
        focus: ( root.state === "settings" )
        opacity: focus
        visible: opacity
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

            //PrevPage sound
            sfxBack.play();

            event.accepted = true;
            if (currentMenuIndex > 0)
                currentMenuIndex--
        }

        if (api.keys.isNextPage(event)) {

            //PrevPage sound
            sfxBack.play();

            event.accepted = true;
            if (currentMenuIndex < (dataMenu.length - 1))
                currentMenuIndex++
        }
    }

    ///////////////////
    // SOUND EFFECTS //
    ///////////////////
    SoundEffect {
        id: sfxNav
        source: "assets/sounds/navigation.wav"
        volume: mutesfx
    }

    SoundEffect {
        id: sfxBack
        source: "assets/sounds/back.wav"
        volume: mutesfx
    }

    SoundEffect {
        id: sfxAccept
        source: "assets/sounds/accept.wav"
        volume: mutesfx
    }

    SoundEffect {
        id: sfxPlay
        source: "assets/sounds/play.wav"
        volume: mutesfx
    }
}
