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
        "apple2":           { manufacturer: "apple",                release: "1977", color: "#009ddc", altColor: "#61bb46" },
        "amstradcpc":       { manufacturer: "amstrad",              release: "1984", color: "#942647", altColor: "#00A651" },
        "atari2600":        { manufacturer: "atari",                release: "1977", color: "#C1272A", altColor: "#1C267D" },
        "atari5200":        { manufacturer: "atari",                release: "1982", color: "#1c6eb8", altColor: "#973e3a" },
        "atarist":          { manufacturer: "atari",                release: "1985", color: "#357BB7", altColor: "#949494" },
        "atari7800":        { manufacturer: "atari",                release: "1986", color: "#333333", altColor: "#AA2C39" },
        "atarilynx":        { manufacturer: "atari",                release: "1989", color: "#262626", altColor: "#F38900" },
        "atarijaguar":      { manufacturer: "atari",                release: "1993", color: "#232326", altColor: "#ff0000" },
        "cps1":             { manufacturer: "capcom",               release: "1988", color: "#000000", altColor: "#252525" },
        "cps2":             { manufacturer: "capcom",               release: "1993", color: "#000000", altColor: "#252525" },
        "cps3":             { manufacturer: "capcom",               release: "1996", color: "#000000", altColor: "#252525" },
        "colecovision":     { manufacturer: "coleco",               release: "1982", color: "#EF8185", altColor: "#A4DDF0" },
        "c64":              { manufacturer: "commodore",            release: "1982", color: "#968971", altColor: "#FD4120" },
        "amiga":            { manufacturer: "commodore",            release: "1985", color: "#192753", altColor: "#ED2224" },
        "intellivision":    { manufacturer: "mattel",               release: "1979", color: "#2b201d", altColor: "#d4c1a0" },
        "msx":              { manufacturer: "microsoft",            release: "1983", color: "#9d9b91", altColor: "#89283b" },
        "msx2":             { manufacturer: "microsoft",            release: "1985", color: "#b7b7b7", altColor: "#7c3036" },
        "pcengine":         { manufacturer: "nec",                  release: "1987", color: "#FE0000", altColor: "#D9D9D9" },
        "turbografx16":     { manufacturer: "nec",                  release: "1987", color: "#333333", altColor: "#F79226" },
        "supergrafx":       { manufacturer: "nec",                  release: "1989", color: "#000000", altColor: "#b2b2b2" },
        "pcfx":             { manufacturer: "nec",                  release: "1994", color: "#5C3073", altColor: "#FEC101" },
        "nes":              { manufacturer: "nintendo",             release: "1983", color: "#EA2C27", altColor: "#1A1919" },
        "fds":              { manufacturer: "nintendo",             release: "1986", color: "#A71636", altColor: "#C7AF89" },
        "gb":               { manufacturer: "nintendo",             release: "1989", color: "#2D308E", altColor: "#9B2063" },
        "snes":             { manufacturer: "nintendo",             release: "1990", color: "#007544", altColor: "#0A2A8D" },
        "n64":              { manufacturer: "nintendo",             release: "1996", color: "#238B41", altColor: "#233387" },
        "gbc":              { manufacturer: "nintendo",             release: "1998", color: "#2D308E", altColor: "#7642B6" },
        "gba":              { manufacturer: "nintendo",             release: "2001", color: "#280FBE", altColor: "#5C67A9" },
        "pokemini":         { manufacturer: "nintendo",             release: "2001", color: "#FCE200", altColor: "#004F8A" },        
        "gc":               { manufacturer: "nintendo",             release: "2001", color: "#524c82", altColor: "#7b79aa" },
        "nds":              { manufacturer: "nintendo",             release: "2004", color: "#BCBCBC", altColor: "#212121" },
        "wii":              { manufacturer: "nintendo",             release: "2006", color: "#005C9A", altColor: "#D1D1D1" },
        "wiiware":          { manufacturer: "nintendo",             release: "2008", color: "#24A9E2", altColor: "#D1D1D1" },
        "3ds":              { manufacturer: "nintendo",             release: "2011", color: "#C02424", altColor: "#929497" },
        "wiiu":             { manufacturer: "nintendo",             release: "2012", color: "#3783BC", altColor: "#1F9EBB" },
        "virtualboy":       { manufacturer: "nintendo",             release: "1995", color: "#FE0016", altColor: "#232323" },
        "switch":           { manufacturer: "nintendo",             release: "2017", color: "#232323", altColor: "#FE0016" },
        "3do":              { manufacturer: "panasonic",            release: "1993", color: "#0000A0", altColor: "#FFE41B" },
        "atomiswave":       { manufacturer: "sammy",                release: "2003", color: "#FF6B00", altColor: "#029205" },
        "mastersystem":     { manufacturer: "sega",                 release: "1985", color: "#165193", altColor: "#E60000" },
        "genesis":          { manufacturer: "sega",                 release: "1988", color: "#212122", altColor: "#181C4E" },
        "megadrive":        { manufacturer: "sega",                 release: "1988", color: "#20211D", altColor: "#DCE3E6" },
        "gamegear":         { manufacturer: "sega",                 release: "1990", color: "#212122", altColor: "#0000FE" },
        "segacd":           { manufacturer: "sega",                 release: "1991", color: "#212122", altColor: "#732A46" },
        "sega32x":          { manufacturer: "sega",                 release: "1994", color: "#212122", altColor: "#F2BA5C" },
        "saturn":           { manufacturer: "sega",                 release: "1994", color: "#20211D", altColor: "#0D7176" },
        "dreamcast":        { manufacturer: "sega",                 release: "1998", color: "#C1C3C2", altColor: "#3e649f" },
        "sg1000":           { manufacturer: "sega",                 release: "1983", color: "#9A2025", altColor: "#BBBDBD" },
        "zxspectrum":       { manufacturer: "sinclair",             release: "1982", color: "#D6A763", altColor: "#000000" },
        "vectrex":          { manufacturer: "smith_engineering",    release: "1982", color: "#166FC1", altColor: "#11192E" },
        "neogeo":           { manufacturer: "snk",                  release: "1990", color: "#2D2D2D", altColor: "#BF9328" },
        "neogeocd":         { manufacturer: "snk",                  release: "1994", color: "#24241E", altColor: "#FFD400" },
        "ngp":              { manufacturer: "snk",                  release: "1998", color: "#E92A30", altColor: "#25374A" },
        "ngpc":             { manufacturer: "snk",                  release: "1999", color: "#E92A30", altColor: "#25374A" },
        "psx":              { manufacturer: "sony",                 release: "1994", color: "#F1C002", altColor: "#252525" },
        "ps2":              { manufacturer: "sony",                 release: "2000", color: "#33438A", altColor: "#40A9A8" },
        "psp":              { manufacturer: "sony",                 release: "2004", color: "#0F1012", altColor: "#97A9BA" },
        "ps3":              { manufacturer: "sony",                 release: "2006", color: "#0D1114", altColor: "#0095D5" },
        "gog":              { manufacturer: "pc",                   release: "2008", color: "#000000", altColor: "#252525" },
        "ports":            { manufacturer: "pc",                   release: null,   color: "#4B77BE", altColor: "#36D7B7" },
        "scummvm":          { manufacturer: "pc",                   release: null,   color: "#379742", altColor: "#C26317" },
        "steam":            { manufacturer: "valve",                release: "2003", color: "#010314", altColor: "#112a40" },
        "arcade":           { manufacturer: "arcade",               release: null,   color: "#FCE236", altColor: "#5D9EED" },
        "all":              { manufacturer: null,                   release: null,   color: "#851740", altColor: "#364792" },
        "daphne":           { manufacturer: "arcade",               release: null,   color: "#856125", altColor: "#DEBA27" },
        "fba":              { manufacturer: "arcade",               release: null,   color: "#231F20", altColor: "#FE7B07" },
        "fbneo":            { manufacturer: "arcade",               release: null,   color: "#FF8200", altColor: "#FFDBA1" },
        "mame":             { manufacturer: "arcade",               release: null,   color: "#231F20", altColor: "#00ADEF" },
        "android":          { manufacturer: "OpenHandsetAlliance",  release: null,   color: "#77c159", altColor: "#478230" }
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
