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
    property variant colorScheme: {
        "Dark": {
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
        },
         "Light": {
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
        },
        "OzoneDark": {
            main: "#2D2D2D",
            secondary: "#333333",
            background: "#2D2D2D",
            text: "white",
            textalt: "#9F9FA1",
            accent: "#00D9AE",
            accentalt:"white",
            icons: "white",
            favorite: "#F3C03B",
            accepted: "#996b00",
            cancel: "#E6140D",
            details: "#00991E",
            filters: "#5365df"
        }   
    }

    // Text strings
    property variant dataText: {
        "en": {
            global_back: "GO <b>BACK</b>",
            global_select: "OK",
            global_games: "GAMES",
            global_noFavorites: "No favorites set",
            collection_all: "All",
            collectionDetails_gamesAvailable: "games available",
            games_na: "N/A",
            games_developedBy: "Developed by",
            games_players: "PLAYERS",
            games_player: "1 PLAYER",
            games_favorited: "FAVORITED",
            games_withoutDescription: "without description",
            games_removeFavorite: "REMOVE <b>FAVORITE</b>",
            games_addFavorite: "ADD <b>FAVORITE</b>",
            games_filterFavorites: "SHOW ALL · <b>FAVORITES</b> · MULTIPLAYER",
            games_filterMultiplayer: "SHOW ALL · FAVORITES · <b>MULTIPLAYER</b>",
            games_filterAll: "SHOW <b>ALL</b> · FAVORITES · MULTIPLAYER",
            home_continue: "Continue playing",
            home_favorites: "Favorites",
            home_play: "Play",
            settings_general: "General",
            settings_general_language: "Language",
            settings_general_colorScheme: "Color scheme",
            settings_general_muteSounds: "Mute sounds",
            settings_general_logoVariant: "Logo variation",
            settings_general_hideOSC: "Hide controls",
            settings_general_OSCScheme: "Controls scheme",
            settings_global_videoPlayback: "Video playback",
            settings_global_videoMute: "Mute video",
            settings_collection_showAll: 'Show "All games" collection',
            settings_collection_accentColor: "Accent color brightness",
            settings_collection_accentColorNr: "Accent colors",
            settings_games_layout: "Games layout",
            menu_settings: "settings",
            menu_home: "home",
            menu_collections: "collections",
            menu_games:"games"
        },
        "de": {
            global_back: "<b>ZURÜCK</b>",
            global_select: "OK",
            global_games: "SPIELE",
            global_noFavorites: "Keine Favoriten gesetzt",
            collection_all: "Alle",
            collectionDetails_gamesAvailable: "Spiele verfügbar",
            games_na: "K.A.",
            games_developedBy: "Entwickelt von",
            games_players: "SPIELER",
            games_player: "1 SPIELER",
            games_favorited: "FAVORISIERT",
            games_withoutDescription: "ohne Beschreibung",
            games_removeFavorite: "<b>FAVORIT</b> entfernen",
            games_addFavorite: "<b>FAVORIT</b> hinzufügen",
            games_filterFavorites: "ZEIGE ALLE · <b>FAVORITEN</b> · MEHRSPIELER",
            games_filterMultiplayer: "ZEIGE ALLE · FAVORITEN · <b>MEHRSPIELER</b>",
            games_filterAll: "ZEIGE <b>ALLE</b> · FAVORITEN · MEHRSPIELER",
            home_continue: "Weiterspielen",
            home_favorites: "Favoriten",
            home_play: "Spiele",
            settings_general: "Allgemein",
            settings_general_language: "Sprache",
            settings_general_colorScheme: "Farbschema",
            settings_general_muteSounds: "Töne stummschalten",
            settings_general_logoVariant: "Logo-Variation",
            settings_general_hideOSC: "Steuerung ausblenden",
            settings_general_OSCScheme: "Steuerungschema",
            settings_global_videoPlayback: "Videowiedergabe",
            settings_global_videoMute: "Video stummschalten",
            settings_collection_showAll: 'Sammlung "Alle Spiele" anzeigen',
            settings_collection_accentColor: "Akzentfarbhelligkeit",
            settings_collection_accentColorNr: "Akzentfarben",
            settings_games_layout: "Spiele-Layout",
            menu_settings: "Optionen",
            menu_home: "Start",
            menu_collections: "Sammlungen",
            menu_games:"Spiele"
        }                
    }

    // Load settings
    property var lang: api.memory.get('lang') || "en"
    property var theme: api.memory.get('theme') || "Dark"
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
    property var accentColorNr : api.memory.get('accentColorNrIndex') || 0
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
            collections.unshift({"name":  dataText[lang].collection_all, "shortName": "all", "games": api.allGames})
        }
        return collections
    }

    property int currentCollectionIndex: api.memory.get("currentCollectionIndex") || 0
    property var currentCollection: allCollections[currentCollectionIndex]

    property variant dataMenu: [
        { name: "settings", title: dataText[lang].menu_settings},
        { name: "home", title: dataText[lang].menu_home},
        { name: "collections", title: dataText[lang].menu_collections},
        { name: "games", title: dataText[lang].menu_games}
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
        "3do":              { manufacturer: "panasonic",            release: "1993", color: "#0000A0", altColor: "#000080" , altColor2: "#FFE41B" },
        "3ds":              { manufacturer: "nintendo",             release: "2011", color: "#C02424", altColor: "#961d1d" , altColor2: "#929497" },
        "64dd":             { manufacturer: "nintendo",             release: "1999", color: "#233387", altColor: "#1a2765" , altColor2: "#238B41" },        
        "all":              { manufacturer: null,                   release: null,   color: "#851740", altColor: "#6d1234" , altColor2: "#364792" },
        "amiga":            { manufacturer: "commodore",            release: "1985", color: "#192753", altColor: "#121b3b" , altColor2: "#ED2224" },
        "amstradcpc":       { manufacturer: "amstrad",              release: "1984", color: "#942647", altColor: "#7a1f3a" , altColor2: "#00A651" },
        "android":          { manufacturer: "OpenHandsetAlliance",  release: null,   color: "#77c159", altColor: "#5ca83e" , altColor2: "#478230" },
        "apple2":           { manufacturer: "apple",                release: "1977", color: "#009ddc", altColor: "#0080b3" , altColor2: "#61bb46" },
        "arcade":           { manufacturer: "arcade",               release: null,   color: "#FCE236", altColor: "#fbda04" , altColor2: "#5D9EED" },
        "atari2600":        { manufacturer: "atari",                release: "1977", color: "#C1272A", altColor: "#941e20" , altColor2: "#1C267D" },
        "atari5200":        { manufacturer: "atari",                release: "1982", color: "#1c6eb8", altColor: "#175e9b" , altColor2: "#973e3a" },
        "atari7800":        { manufacturer: "atari",                release: "1986", color: "#333333", altColor: "#1a1a1a" , altColor2: "#AA2C39" },
        "atarijaguar":      { manufacturer: "atari",                release: "1993", color: "#232326", altColor: "#0c0c0d" , altColor2: "#ff0000" },
        "atarilynx":        { manufacturer: "atari",                release: "1989", color: "#262626", altColor: "#0d0d0d" , altColor2: "#F38900" },
        "atarist":          { manufacturer: "atari",                release: "1985", color: "#357BB7", altColor: "#2e6a9e" , altColor2: "#949494" },
        "atomiswave":       { manufacturer: "sammy",                release: "2003", color: "#FF6B00", altColor: "#cc5500" , altColor2: "#029205" },
        "c64":              { manufacturer: "commodore",            release: "1982", color: "#968971", altColor: "#847862" , altColor2: "#FD4120" },
        "colecovision":     { manufacturer: "coleco",               release: "1982", color: "#EF8185", altColor: "#ea6166" , altColor2: "#A4DDF0" },
        "cps1":             { manufacturer: "capcom",               release: "1988", color: "#000000", altColor: "#252525" , altColor2: "#252525" },
        "cps2":             { manufacturer: "capcom",               release: "1993", color: "#000000", altColor: "#252525" , altColor2: "#252525" },
        "cps3":             { manufacturer: "capcom",               release: "1996", color: "#000000", altColor: "#252525" , altColor2: "#252525" },
        "daphne":           { manufacturer: "arcade",               release: null,   color: "#856125", altColor: "#63481c" , altColor2: "#DEBA27" },
        "dreamcast":        { manufacturer: "sega",                 release: "1998", color: "#C1C3C2", altColor: "#b1b4b3" , altColor2: "#3e649f" },
        "fba":              { manufacturer: "arcade",               release: null,   color: "#231F20", altColor: "#0e0c0c" , altColor2: "#FE7B07" },
        "fbneo":            { manufacturer: "arcade",               release: null,   color: "#FF8200", altColor: "#cc6900" , altColor2: "#FFDBA1" },
        "fds":              { manufacturer: "nintendo",             release: "1986", color: "#A71636", altColor: "#87122b" , altColor2: "#C7AF89" },
        "gamegear":         { manufacturer: "sega",                 release: "1990", color: "#212122", altColor: "#0d0d0d" , altColor2: "#0000FE" },
        "gba":              { manufacturer: "nintendo",             release: "2001", color: "#280FBE", altColor: "#1f0b8e" , altColor2: "#5C67A9" },
        "gbc":              { manufacturer: "nintendo",             release: "1998", color: "#2D308E", altColor: "#252774" , altColor2: "#7642B6" },
        "gb":               { manufacturer: "nintendo",             release: "1989", color: "#2D308E", altColor: "#252774" , altColor2: "#9B2063" },
        "gc":               { manufacturer: "nintendo",             release: "2001", color: "#524c82", altColor: "#3d3960" , altColor2: "#7b79aa" },
        "genesis":          { manufacturer: "sega",                 release: "1988", color: "#212122", altColor: "#0d0d0d" , altColor2: "#181C4E" },
        "gog":              { manufacturer: "pc",                   release: "2008", color: "#000000", altColor: "#1a1a1a" , altColor2: "#252525" },
        "intellivision":    { manufacturer: "mattel",               release: "1979", color: "#2b201d", altColor: "#0f0b0a" , altColor2: "#d4c1a0" },
        "mame":             { manufacturer: "arcade",               release: null,   color: "#231F20", altColor: "#0e0c0c" , altColor2: "#00ADEF" },
        "mastersystem":     { manufacturer: "sega",                 release: "1985", color: "#165193", altColor: "#113d6f" , altColor2: "#E60000" },
        "megadrive":        { manufacturer: "sega",                 release: "1988", color: "#20211D", altColor: "#0d0e0c" , altColor2: "#DCE3E6" },
        "msx2":             { manufacturer: "microsoft",            release: "1985", color: "#b7b7b7", altColor: "#a6a6a6" , altColor2: "#7c3036" },
        "msx":              { manufacturer: "microsoft",            release: "1983", color: "#9d9b91", altColor: "#878578" , altColor2: "#89283b" },
        "n64":              { manufacturer: "nintendo",             release: "1996", color: "#238B41", altColor: "#19662f" , altColor2: "#233387" },
        "nds":              { manufacturer: "nintendo",             release: "2004", color: "#BCBCBC", altColor: "#a6a6a6" , altColor2: "#212121" },
        "neogeocd":         { manufacturer: "snk",                  release: "1994", color: "#24241E", altColor: "#0e0e0c" , altColor2: "#FFD400" },
        "neogeo":           { manufacturer: "snk",                  release: "1990", color: "#2D2D2D", altColor: "#1a1a1a" , altColor2: "#BF9328" },
        "nes":              { manufacturer: "nintendo",             release: "1983", color: "#EA2C27", altColor: "#d11b15" , altColor2: "#1A1919" },
        "ngpc":             { manufacturer: "snk",                  release: "1999", color: "#E92A30", altColor: "#d0161c" , altColor2: "#25374A" },
        "ngp":              { manufacturer: "snk",                  release: "1998", color: "#E92A30", altColor: "#d0161c" , altColor2: "#25374A" },
        "pcengine":         { manufacturer: "nec",                  release: "1987", color: "#FE0000", altColor: "#cc0000" , altColor2: "#D9D9D9" },
        "pcfx":             { manufacturer: "nec",                  release: "1994", color: "#5C3073", altColor: "#48265a" , altColor2: "#FEC101" },
        "pokemini":         { manufacturer: "nintendo",             release: "2001", color: "#FCE200", altColor: "#ccb800" , altColor2: "#004F8A" },        
        "ports":            { manufacturer: "pc",                   release: null,   color: "#4B77BE", altColor: "#3d66a9" , altColor2: "#36D7B7" },
        "ps2":              { manufacturer: "sony",                 release: "2000", color: "#33438A", altColor: "#293670" , altColor2: "#40A9A8" },
        "ps3":              { manufacturer: "sony",                 release: "2006", color: "#0D1114", altColor: "#000000" , altColor2: "#0095D5" },
        "psp":              { manufacturer: "sony",                 release: "2004", color: "#0F1012", altColor: "#000000" , altColor2: "#97A9BA" },
        "psx":              { manufacturer: "sony",                 release: "1994", color: "#F1C002", altColor: "#caa202" , altColor2: "#252525" },
        "saturn":           { manufacturer: "sega",                 release: "1994", color: "#20211D", altColor: "#0d0e0c" , altColor2: "#0D7176" },
        "scummvm":          { manufacturer: "pc",                   release: null,   color: "#379742", altColor: "#297031" , altColor2: "#C26317" },
        "sega32x":          { manufacturer: "sega",                 release: "1994", color: "#212122", altColor: "#0d0e0c" , altColor2: "#F2BA5C" },
        "segacd":           { manufacturer: "sega",                 release: "1991", color: "#212122", altColor: "#0d0d0d" , altColor2: "#732A46" },
        "sg1000":           { manufacturer: "sega",                 release: "1983", color: "#9A2025", altColor: "#7f1a1d" , altColor2: "#BBBDBD" },
        "snes":             { manufacturer: "nintendo",             release: "1990", color: "#007544", altColor: "#004d2d" , altColor2: "#0A2A8D" },
        "steam":            { manufacturer: "valve",                release: "2003", color: "#010314", altColor: "#030730" , altColor2: "#112a40" },
        "supergrafx":       { manufacturer: "nec",                  release: "1989", color: "#000000", altColor: "#1a1a1a" , altColor2: "#b2b2b2" },
        "switch":           { manufacturer: "nintendo",             release: "2017", color: "#232323", altColor: "#0d0d0d" , altColor2: "#FE0016" },
        "turbografx16":     { manufacturer: "nec",                  release: "1987", color: "#333333", altColor: "#1a1a1a" , altColor2: "#F79226" },
        "vectrex":          { manufacturer: "smith_engineering",    release: "1982", color: "#166FC1", altColor: "#125ca1" , altColor2: "#11192E" },
        "virtualboy":       { manufacturer: "nintendo",             release: "1995", color: "#FE0016", altColor: "#cc0011" , altColor2: "#232323" },
        "wii":              { manufacturer: "nintendo",             release: "2006", color: "#005C9A", altColor: "#003d66" , altColor2: "#D1D1D1" },
        "wiiu":             { manufacturer: "nintendo",             release: "2012", color: "#3783BC", altColor: "#2e6d9e" , altColor2: "#1F9EBB" },
        "wiiware":          { manufacturer: "nintendo",             release: "2008", color: "#24A9E2", altColor: "#1a96cb" , altColor2: "#D1D1D1" },
        "zxspectrum":       { manufacturer: "sinclair",             release: "1982", color: "#D6A763", altColor: "#cf974a" , altColor2: "#000000" }
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
        color: colorScheme[theme].background
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
