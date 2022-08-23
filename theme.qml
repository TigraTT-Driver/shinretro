import QtQuick 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.12
import QtMultimedia 5.15
import QtQml.Models 2.15
import SortFilterProxyModel 0.2

import "Home"
import "Collections"
import "Menu"
import "Games"
import "Settings"
import "BGM"

FocusScope {
    id: root

    focus: true

    FontLoader { id: montserratMedium; source: "./assets/fonts/Montserrat-Medium.ttf" }
    FontLoader { id: montserratBold; source: "./assets/fonts/Montserrat-Bold.ttf" }
    FontLoader { id: robotoSlabLight; source: "./assets/fonts/RobotoSlab-Light.ttf" }
    FontLoader { id: robotoSlabThin; source: "./assets/fonts/RobotoSlab-Thin.ttf" }
    FontLoader { id: robotoSlabRegular; source: "./assets/fonts/RobotoSlab-Regular.ttf" }
    FontLoader {
        id: glyphs;
        property string favorite: '\ue800';
        property string fullStar: '\ue801';
        property string emptyStar: '\ue802';
        property string halfStar: '\ue803';
        property string uInputBtnD: '\ue804';
        property string uInputBtnL: '\ue805';
        property string uInputBtnLb: '\ue806';
        property string uInputBtnLt: '\ue807';
        property string uInputBtnR: '\ue808';
        property string uInputBtnRb: '\ue809';
        property string uInputBtnRt: '\ue80a';
        property string uInputBtnU: '\ue80b';
        property string xInputBtnD: '\ue80c';
        property string xInputBtnL: '\ue80d';
        property string xInputBtnLb: '\ue80e';
        property string xInputBtnLt: '\ue80f';
        property string xInputBtnR: '\ue810';
        property string xInputBtnRb: '\ue811';
        property string xInputBtnRt: '\ue812';
        property string xInputBtnU: '\ue813';
        property string pInputBtnD: '\ue814';
        property string pInputBtnL: '\ue815';
        property string pInputBtnLb: '\ue816';
        property string pInputBtnLt: '\ue817';
        property string pInputBtnR: '\ue818';
        property string pInputBtnRb: '\ue819';
        property string pInputBtnRt: '\ue81a';
        property string pInputBtnU: '\ue81b';
        property string search: '\ue81c';
        property string spinner: '\ue839';
        property string disabled: '\uf204';
        property string enabled: '\uf205';
        source: "assets/fonts/glyphs.ttf";
    }
    // Control schemes
    property variant osdScheme: {
        "Universal": {
            BTND: glyphs.uInputBtnD,
            BTNL: glyphs.uInputBtnL,
            BTNLB: glyphs.uInputBtnLb,
            BTNLT: glyphs.uInputBtnLt,
            BTNR: glyphs.uInputBtnR,
            BTNRB: glyphs.uInputBtnRb,
            BTNRT:glyphs.uInputBtnRt,
            BTNU: glyphs.uInputBtnU
        },
        "Universal-JP": {
            BTND: glyphs.uInputBtnR,
            BTNL: glyphs.uInputBtnU,
            BTNLB: glyphs.uInputBtnLb,
            BTNLT: glyphs.uInputBtnLt,
            BTNR: glyphs.uInputBtnD,
            BTNRB: glyphs.uInputBtnRb,
            BTNRT:glyphs.uInputBtnRt,
            BTNU: glyphs.uInputBtnL
        },
        "XBOX": {
            BTND: glyphs.xInputBtnD,
            BTNL: glyphs.xInputBtnL,
            BTNLB: glyphs.xInputBtnLb,
            BTNLT: glyphs.xInputBtnLt,
            BTNR: glyphs.xInputBtnR,
            BTNRB: glyphs.xInputBtnRb,
            BTNRT:glyphs.xInputBtnRt,
            BTNU: glyphs.xInputBtnU
        },
        "PS": {
            BTND: glyphs.pInputBtnD,
            BTNL: glyphs.pInputBtnL,
            BTNLB: glyphs.pInputBtnLb,
            BTNLT: glyphs.pInputBtnLt,
            BTNR: glyphs.pInputBtnR,
            BTNRB: glyphs.pInputBtnRb,
            BTNRT:glyphs.pInputBtnRt,
            BTNU: glyphs.pInputBtnU
        },
        "PS-JP": {
            BTND: glyphs.pInputBtnR,
            BTNL: glyphs.pInputBtnU,
            BTNLB: glyphs.pInputBtnLb,
            BTNLT: glyphs.pInputBtnLt,
            BTNR: glyphs.pInputBtnD,
            BTNRB: glyphs.pInputBtnRb,
            BTNRT:glyphs.pInputBtnRt,
            BTNU: glyphs.pInputBtnL
        }
    }
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
        },
        "SteamOS": {
            main: "black",
            secondary: "#0e141b",
            background: "#2b2f38",
            text: "white",
            textalt: "#EBEBEB",
            accent: "#1a9fff",
            accentalt:"white",
            icons: "white",
            favorite: "#cc8f00",
            accepted: "#EBEBEB",
            cancel: "#EBEBEB",
            details: "#EBEBEB",
            filters: "#EBEBEB"
        }
    }

    // Text strings
    property variant dataText: {
        "en": {
            settings_collection_accentColor_dimm: "dimm",
            settings_collection_accentColor_bright: "bright",
            settings_general_colorScheme_Dark: "Dark",
            settings_general_colorScheme_Light: "Light",
            settings_general_colorScheme_OzoneDark: "OzoneDark",
            settings_general_colorScheme_SteamOS: "SteamOS",
            settings_general_logoVariant_mono: "mono",
            settings_general_logoVariant_color: "color",
            global_yes: "Yes",
            global_no: "No",
            global_back: "GO <b>BACK</b>",
            global_select: "OK",
            global_games: "GAMES",
            global_noFavorites: "No favorites set",
            global_noFilteredGames: "No results for the current search",
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
            games_filtered: "<b>FILTERS</b>",
            games_filterMultiplayer: "Multiplayer",
            games_filter: "FILTERS",
            home_continue: "Continue playing",
            home_favorites: "Favorites",
            home_play: "Play",
            settings_general: "General",
            settings_general_restart: "(Requires restart)",
            settings_general_language: "Language",
            settings_general_colorScheme: "Color scheme",
            settings_general_music: "Music",
            settings_general_muteSounds: "Mute sounds",
            settings_general_logoVariant: "Logo variation",
            settings_general_region: "Region",
            settings_general_hideOSC: "Hide controls",
            settings_general_dynamicFontScaling: "Dynamic font scaling",
            settings_general_OSCScheme: "Controls scheme",
            settings_global_videoPlayback: "Video playback",
            settings_global_videoMute: "Mute video",
            settings_collection_showAll: 'Show "All games" collection',
            settings_collection_accentColor: "Accent color brightness",
            settings_collection_accentColorNr: "Accent colors",
            settings_games_layout: "Games layout",
            settings_games_gridItemsPerRow: "Game grid - items per row",
            settings_games_gridItemsViewableRows: "Game grid - viewable rows",
            menu_settings: "settings",
            menu_home: "home",
            menu_collections: "collections",
            menu_games:"games"
        },
        "de": {
            settings_collection_accentColor_dimm: "Gedämpft",
            settings_collection_accentColor_bright: "Leuchtend",
            settings_general_colorScheme_Dark: "Dunkel",
            settings_general_colorScheme_Light: "Hell",
            settings_general_colorScheme_OzoneDark: "OzoneDark",
            settings_general_colorScheme_SteamOS: "SteamOS",
            settings_general_logoVariant_mono: "Einfarbig",
            settings_general_logoVariant_color: "Bunt",
            global_yes: "Ja",
            global_no: "Nein",
            global_back: "<b>ZURÜCK</b>",
            global_select: "OK",
            global_games: "SPIELE",
            global_noFavorites: "Keine Favoriten gesetzt",
            global_noFilteredGames: "Keine Ergebnisse für die aktuelle Suche",
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
            games_filtered: "<b>FILTER</b>",
            games_filterMultiplayer: "Mehrspieler",
            games_filter: "FILTER",
            home_continue: "Weiterspielen",
            home_favorites: "Favoriten",
            home_play: "Spiele",
            settings_general: "Allgemein",
            settings_general_restart: "(Benötigt Neustart)",
            settings_general_language: "Sprache",
            settings_general_colorScheme: "Farbschema",
            settings_general_music: "Musik",
            settings_general_muteSounds: "Töne stummschalten",
            settings_general_logoVariant: "Logo-Variation",
            settings_general_region: "Region",
            settings_general_hideOSC: "Steuerung ausblenden",
            settings_general_dynamicFontScaling: "Dynamische Schriftskalierung",
            settings_general_OSCScheme: "Steuerungschema",
            settings_global_videoPlayback: "Videowiedergabe",
            settings_global_videoMute: "Video stummschalten",
            settings_collection_showAll: 'Sammlung "Alle Spiele" anzeigen',
            settings_collection_accentColor: "Akzentfarbhelligkeit",
            settings_collection_accentColorNr: "Akzentfarben",
            settings_games_layout: "Spiele-Layout",
            settings_games_gridItemsPerRow: "Spiele Raster - Objekte pro Reihe",
            settings_games_gridItemsViewableRows: "Spiele Raster - Sichtbare Reihen",
            menu_settings: "Optionen",
            menu_home: "Start",
            menu_collections: "Sammlungen",
            menu_games:"Spiele"
        },
        "fr": {
            settings_collection_accentColor_dimm: "Assombrir",
            settings_collection_accentColor_bright: "Illuminer",
            settings_general_colorScheme_Dark: "Sombre",
            settings_general_colorScheme_Light: "Clair",
            settings_general_colorScheme_OzoneDark: "OzoneDark",
            settings_general_colorScheme_SteamOS: "SteamOS",
            settings_general_logoVariant_mono: "Monochrome",
            settings_general_logoVariant_color: "Couleur",
            global_yes: "Oui",
            global_no: "Non",
            global_back: "<b>RETOUR</b>",
            global_select: "OK",
            global_games: "JEUX",
            global_noFavorites: "Aucun jeu en favoris",
            global_noFilteredGames: "Aucun résultat pour la recherche actuelle",
            collection_all: "Tous",
            collectionDetails_gamesAvailable: "Jeux disponibles",
            games_na: "NC",
            games_developedBy: "Developpé par",
            games_players: "JOUEURS",
            games_player: "1 JOUEUR",
            games_favorited: "FAVORIS",
            games_withoutDescription: "sans description",
            games_removeFavorite: "RETIRER DES <b>FAVORIS</b>",
            games_addFavorite: "AJOUTER AUX <b>FAVORIS</b>",
            games_filtered: "<b>FILTRES</b>",
            games_filterMultiplayer: "Multijoueur",
            games_filter: "FILTRES",
            home_continue: "Joué récemment",
            home_favorites: "Favoris",
            home_play: "Jouer",
            settings_general: "Général",
            settings_general_restart: "(Redémarrage nécessaire)",
            settings_general_language: "Langue",
            settings_general_colorScheme: "Style de couleur",
            settings_general_music: "Musique",
            settings_general_muteSounds: "Désactiver le son",
            settings_general_logoVariant: "Style des logos",
            settings_general_region: "Région",
            settings_general_hideOSC: "Masquer les contrôles",
            settings_general_dynamicFontScaling: "Mise à l'échelle dynamique des polices",
            settings_general_OSCScheme: "Style des contrôles",
            settings_global_videoPlayback: "Activer les vidéos",
            settings_global_videoMute: "Désactiver le son des vidéos",
            settings_collection_showAll: 'Afficher la collection "Tous"',
            settings_collection_accentColor:  "Accentuer la luminosité des couleurs",
            settings_collection_accentColorNr: "Accentuer les couleurs",
            settings_games_layout: "Mise en page des jeux",
            settings_games_gridItemsPerRow: "Grille - nombre de jeux par ligne",
            settings_games_gridItemsViewableRows: "Grille - nombre de lignes",
            menu_settings: "Réglages",
            menu_home: "Accueil",
            menu_collections: "Collections",
            menu_games:"Jeux"
        },
        "pt": {
            settings_collection_accentColor_dimm: "dimm",
            settings_collection_accentColor_bright: "bright",
            settings_general_colorScheme_Dark: "Dark",
            settings_general_colorScheme_Light: "Light",
            settings_general_colorScheme_OzoneDark: "OzoneDark",
            settings_general_colorScheme_SteamOS: "SteamOS",
            settings_general_logoVariant_mono: "mono",
            settings_general_logoVariant_color: "color",
            global_yes: "Sim",
            global_no: "Não",
            global_back: "<b>VOLTAR</b>",
            global_select: "OK",
            global_games: "JOGOS",
            global_noFavorites: "Nenhum jogo favorito",
            global_noFilteredGames: "Sem resultados para a busca actual",
            collection_all: "Todos",
            collectionDetails_gamesAvailable: "Jogos disponíveis",
            games_na: "N/A",
            games_developedBy: "Desenvolvido por",
            games_players: "JOGADORES",
            games_player: "1 JOGADOR",
            games_favorited: "FAVORITO",
            games_withoutDescription: "sem descrição",
            games_removeFavorite: "REMOVER <b>FAVORITO</b>",
            games_addFavorite: "ADICIONAR <b>FAVORITO</b>",
            games_filtered: "<b>FILTROS</b>",
            games_filterMultiplayer: "Multijogador",
            home_continue: "Continuar jogando",
            home_favorites: "Favoritos",
            home_play: "Jogar",
            settings_general: "Geral",
            settings_general_restart: "(Requer reinício)",
            settings_general_language: "Idioma",
            settings_general_colorScheme: "Estilo de cores",
            settings_general_music: "Música",
            settings_general_muteSounds: "Silenciar sons",
            settings_general_logoVariant: "Estilo de logos",
            settings_general_region: "Região",
            settings_general_hideOSC: "Ocultar controles",
            settings_general_dynamicFontScaling: "Dynamic font scaling",
            settings_general_OSCScheme: "Estilo de controle",
            settings_global_videoPlayback: "Reprodução de vídeo",
            settings_global_videoMute: "Silenciar vídeo",
            settings_collection_showAll: 'Mostrar a coleção "Todos jogos"',
            settings_collection_accentColor: "Brilho da cor de destaque",
            settings_collection_accentColorNr: "Cores de destaque",
            settings_games_layout: "Layout do jogos",
            settings_games_gridItemsPerRow: "Grade - Jogos por fileira",
            settings_games_gridItemsViewableRows: "Grade - Fileiras visíveis",
            menu_settings: "ajustes",
            menu_home: "início",
            menu_collections: "coleções",
            menu_games:"jogos"
        }
    }

    Music { id: music}
    // Load settings

    property var playBGM: {
        if (api.memory.get('musicIndex') == 1) {
            playBGM: true;
        } else {
            playBGM: false;
        }
    }
    property var lang: api.memory.get('lang') || "en"
    property var theme: {
        if (api.memory.get('themeIndex') == "1") {
            return "Light";
        } else if (api.memory.get('themeIndex') == "2") {
            return "OzoneDark";
        } else if (api.memory.get('themeIndex') == "3") {
            return "SteamOS";
        } else {
            return "Dark";
        }
    }
    property var logoVariant: {
        if (api.memory.get('logoVariantIndex') == "1") {
            return "color";
        } else {
            return "mono";
        }
    }
    property var region: api.memory.get('region') || "pal"
    property var controlScheme: api.memory.get('controlScheme') || "Universal"
    property var osc: api.memory.get('oscIndex') || 0
    property double fontScalingFactor: {
        if (api.memory.get('dynamicFontScalingIndex') == "1") {
            if  ((Math.round(Screen.pixelDensity * 10) / 100) >= 1.5)
                return "1.5";
            else if ((Math.round(Screen.pixelDensity * 10) / 100) >= 1.0)
                return (Math.round(Screen.pixelDensity * 10) / 100);
            else
                return "1.0";
        } else {
            return "1.0";
        }
    }
    property var mutesfx: {
        if (api.memory.get('mutesfxIndex') == "1") {
            return "0.0";
        } else {
            return "1.0";
        }
    }
    property var homeVideo: api.memory.get('homeVideoIndex') || 0
    property var homeVideoMute: {
        if (api.memory.get('homeVideoMuteIndex') == "1") {
            return true;
        } else {
            return false;
        }
    }
    property var accentColor: {
        if (api.memory.get('accentColorIndex') == "1") {
            return "bright";
        } else {
            return "dimm";
        }
    }
    property var accentColorNr: api.memory.get('accentColorNrIndex') || 0
    property var allGamesCollection: api.memory.get('allGamesCollectionIndex') || 0
    property var collectionVideo: api.memory.get('collectionVideoIndex') || 0
    property var collectionVideoMute: {
        if (api.memory.get('collectionVideoMuteIndex') == "1") {
            return true;
        } else {
            return false;
        }
    }
    property var gamesLayout: api.memory.get('gamesLayout') || "BoxArt-Grid"
    property var gamesGridIPR: api.memory.get('gamesGridIPR') || 4
    property var gamesGridVR: api.memory.get('gamesGridVR') || 1
    property var gamesVideo: api.memory.get('gamesVideoIndex') || 0
    property var gamesVideoMute: {
        if (api.memory.get('gamesVideoMuteIndex') == "1") {
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
        if (allGamesCollection != "1") {
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
        "adam":             { manufacturer: "coleco",               release: "1983", color: "#A4DDF0", altColor: "#7bceea" , altColor2: "#F3994B" },
        "advision":         { manufacturer: "entexIndustries",      release: "1982", color: "#b3000f", altColor: "#80000b" , altColor2: "#ee7811" },
        "ags":              { manufacturer: "pc",                   release: null,   color: "#0068ff", altColor: "#0052cc" , altColor2: "#ffffff" },
        "all":              { manufacturer: "various",              release: null,   color: "#851740", altColor: "#6d1234" , altColor2: "#364792" },
        "amiga":            { manufacturer: "commodore",            release: "1985", color: "#192753", altColor: "#121b3b" , altColor2: "#ED2224" },
        "amiga600":         { manufacturer: "commodore",            release: "1992", color: "#192753", altColor: "#121b3b" , altColor2: "#ED2224" },
        "amiga1200":        { manufacturer: "commodore",            release: "1992", color: "#ED2224", altColor: "#d41114" , altColor2: "#192753" },
        "amigacd32":        { manufacturer: "commodore",            release: "1993", color: "#FF5853", altColor: "#ff3a33" , altColor2: "#4A9BE4" },
        "amigacdtv":        { manufacturer: "commodore",            release: "1991", color: "#C86388", altColor: "#bd426f" , altColor2: "#F62717" },
        "amstradcpc":       { manufacturer: "amstrad",              release: "1984", color: "#942647", altColor: "#7a1f3a" , altColor2: "#00A651" },
        "android":          { manufacturer: "OpenHandsetAlliance",  release: null,   color: "#77c159", altColor: "#5ca83e" , altColor2: "#478230" },
        "apfm1000":         { manufacturer: "apf",                  release: "1978", color: "#9a5f41", altColor: "#7e4d35" , altColor2: "#373632" },
        "apple2":           { manufacturer: "apple",                release: "1977", color: "#009ddc", altColor: "#0080b3" , altColor2: "#61bb46" },
        "apple2gs":         { manufacturer: "apple",                release: "1986", color: "#D27C35", altColor: "#bc6b29" , altColor2: "#8C3E8C" },
        "arcade":           { manufacturer: "arcade_all",           release: null,   color: "#FCE236", altColor: "#fbda04" , altColor2: "#5D9EED" },
        "astrocade":        { manufacturer: "bally",                release: "1978", color: "#D27C35", altColor: "#cca300" , altColor2: "#9a5f41" },
        "atari800":         { manufacturer: "atari",                release: "1979", color: "#b6b896", altColor: "#9fa276" , altColor2: "#ebd335" },
        "atari2600":        { manufacturer: "atari",                release: "1977", color: "#C1272A", altColor: "#941e20" , altColor2: "#1C267D" },
        "atari5200":        { manufacturer: "atari",                release: "1982", color: "#1c6eb8", altColor: "#175e9b" , altColor2: "#973e3a" },
        "atari7800":        { manufacturer: "atari",                release: "1986", color: "#333333", altColor: "#1a1a1a" , altColor2: "#AA2C39" },
        "atarijaguar":      { manufacturer: "atari",                release: "1993", color: "#232326", altColor: "#0c0c0d" , altColor2: "#ff0000" },
        "atarijaguarcd":    { manufacturer: "atari",                release: "1995", color: "#ff0000", altColor: "#cc0000" , altColor2: "#232326" },
        "atarilynx":        { manufacturer: "atari",                release: "1989", color: "#262626", altColor: "#0d0d0d" , altColor2: "#F38900" },
        "atarist":          { manufacturer: "atari",                release: "1985", color: "#357BB7", altColor: "#2e6a9e" , altColor2: "#949494" },
        "atarixe":          { manufacturer: "atari",                release: "1987", color: "#ab9ba6", altColor: "#978290" , altColor2: "#250d16" },
        "atomiswave":       { manufacturer: "sammy",                release: "2003", color: "#FF6B00", altColor: "#cc5500" , altColor2: "#029205" },
        "bbcmicro":         { manufacturer: "acorn",                release: "1981", color: "#1c0b0a", altColor: "#000000" , altColor2: "#26250e" },
        "c128":             { manufacturer: "commodore",            release: "1985", color: "#BBAD93", altColor: "#a79472" , altColor2: "#FD4120" },
        "c64":              { manufacturer: "commodore",            release: "1982", color: "#968971", altColor: "#847862" , altColor2: "#FD4120" },
        "cdi":              { manufacturer: "philips",              release: "1991", color: "#1e0a0a", altColor: "#000000" , altColor2: "#1f0b0b" },
        "channelf":         { manufacturer: "fairchild",            release: "1976", color: "#E0E0E0", altColor: "#cccccc" , altColor2: "#4B3FF3" },
        "coco":             { manufacturer: "tandy",                release: "1980", color: "#93a3b3", altColor: "#798ca0" , altColor2: "#3a3b40" },
        "colecovision":     { manufacturer: "coleco",               release: "1982", color: "#EF8185", altColor: "#ea6166" , altColor2: "#A4DDF0" },
        "cplus4":           { manufacturer: "commodore",            release: "1983", color: "#BBAD93", altColor: "#a79472" , altColor2: "#00A0C6" },
        "cps1":             { manufacturer: "capcom",               release: "1988", color: "#000000", altColor: "#252525" , altColor2: "#252525" },
        "cps2":             { manufacturer: "capcom",               release: "1993", color: "#000000", altColor: "#252525" , altColor2: "#252525" },
        "cps3":             { manufacturer: "capcom",               release: "1996", color: "#000000", altColor: "#252525" , altColor2: "#252525" },
        "daphne":           { manufacturer: "arcade",               release: null,   color: "#856125", altColor: "#63481c" , altColor2: "#DEBA27" },
        "dos":              { manufacturer: "ibm",                  release: "1981", color: "#666870", altColor: "#55575e" , altColor2: "#1F70C1" },
        "dragon32":         { manufacturer: "dragonData",           release: "1982", color: "#F50019", altColor: "#cc0014" , altColor2: "#74B719" },
        "dreamcast":        { manufacturer: "sega",                 release: "1998", color: "#C1C3C2", altColor: "#b1b4b3" , altColor2: "#3e649f" },
        "famicom":          { manufacturer: "nintendo",             release: "1983", color: "#AA1C41", altColor: "#841533" , altColor2: "#C0A987" },
        "fba":              { manufacturer: "arcade",               release: null,   color: "#231F20", altColor: "#0e0c0c" , altColor2: "#FE7B07" },
        "fbneo":            { manufacturer: "arcade",               release: null,   color: "#FF8200", altColor: "#cc6900" , altColor2: "#FFDBA1" },
        "fds":              { manufacturer: "nintendo",             release: "1986", color: "#A71636", altColor: "#87122b" , altColor2: "#C7AF89" },
        "fmtowns":          { manufacturer: "fujitsu",              release: "1989", color: "#dfe0df", altColor: "#cbcdcb" , altColor2: "#8c8c8b" },
        "gamate":           { manufacturer: "bitCorporation",       release: "1990", color: "#fffc6d", altColor: "#fffc4d" , altColor2: "#464a53" },
        "gameandwatch":     { manufacturer: "nintendo",             release: "1980", color: "#7b0000", altColor: "#4d0000" , altColor2: "#ffffff" },
        "gamegear":         { manufacturer: "sega",                 release: "1990", color: "#212122", altColor: "#0d0d0d" , altColor2: "#0000FE" },
        "gba":              { manufacturer: "nintendo",             release: "2001", color: "#280FBE", altColor: "#1f0b8e" , altColor2: "#5C67A9" },
        "gbc":              { manufacturer: "nintendo",             release: "1998", color: "#2D308E", altColor: "#252774" , altColor2: "#7642B6" },
        "gb":               { manufacturer: "nintendo",             release: "1989", color: "#2D308E", altColor: "#252774" , altColor2: "#9B2063" },
        "gc":               { manufacturer: "nintendo",             release: "2001", color: "#524c82", altColor: "#3d3960" , altColor2: "#7b79aa" },
        "genesis":          { manufacturer: "sega",                 release: "1988", color: "#212122", altColor: "#0d0d0d" , altColor2: "#181C4E" },
        "gog":              { manufacturer: "cdproject",            release: "2008", color: "#1d1d1d", altColor: "#0d0d0d" , altColor2: "#6d1d72" },
        "gx4000":           { manufacturer: "amstrad",              release: "1990", color: "#9E4968", altColor: "#7a3850" , altColor2: "#DBD9D4" },
        "intellivision":    { manufacturer: "mattel",               release: "1979", color: "#2b201d", altColor: "#0f0b0a" , altColor2: "#d4c1a0" },
        "kodi":             { manufacturer: "media",                release: null,   color: "#186AAC", altColor: "#125287" , altColor2: "#36A2CD" },
        "linux":            { manufacturer: null,                   release: "1991", color: "#ebc40c", altColor: "#c2a30a" , altColor2: "#141413" },
        "love":             { manufacturer: "pc",                   release: null,   color: "#3b6fc6", altColor: "#2e579e" , altColor2: "#e3e3e3" },
        "macintosh":        { manufacturer: "apple",                release: "1984", color: "#76B845", altColor: "#609438" , altColor2: "#009DDD" },
        "mame":             { manufacturer: "arcade",               release: null,   color: "#231F20", altColor: "#0e0c0c" , altColor2: "#00ADEF" },
        "mastersystem":     { manufacturer: "sega",                 release: "1985", color: "#165193", altColor: "#113d6f" , altColor2: "#E60000" },
        "megadrive":        { manufacturer: "sega",                 release: "1988", color: "#20211D", altColor: "#0d0e0c" , altColor2: "#DCE3E6" },
        "moto":             { manufacturer: "thomson",              release: "1986", color: "#E6F0EF", altColor: "#cfe2e0" , altColor2: "#4F8E5C" },
        "msx2":             { manufacturer: "microsoft_t1986",      release: "1985", color: "#b7b7b7", altColor: "#a6a6a6" , altColor2: "#7c3036" },
        "msx":              { manufacturer: "microsoft_t1986",      release: "1983", color: "#9d9b91", altColor: "#878578" , altColor2: "#89283b" },
        "msxturbor":        { manufacturer: "panasonic",            release: "1990", color: "#637080", altColor: "#4e5865" , altColor2: "#99784b" },
        "n64":              { manufacturer: "nintendo",             release: "1996", color: "#238B41", altColor: "#19662f" , altColor2: "#233387" },
        "naomi":            { manufacturer: "sega",                 release: "1998", color: "#C75433", altColor: "#a2442a" , altColor2: "#E4E7D7" },
        "naomigd":          { manufacturer: "sega",                 release: "1998", color: "#243551", altColor: "#182335" , altColor2: "#E4E7D7" },
        "nds":              { manufacturer: "nintendo",             release: "2004", color: "#BCBCBC", altColor: "#a6a6a6" , altColor2: "#212121" },
        "neogeocd":         { manufacturer: "snk",                  release: "1994", color: "#24241E", altColor: "#0e0e0c" , altColor2: "#FFD400" },
        "neogeo":           { manufacturer: "snk",                  release: "1990", color: "#2D2D2D", altColor: "#1a1a1a" , altColor2: "#BF9328" },
        "nes":              { manufacturer: "nintendo",             release: "1983", color: "#EA2C27", altColor: "#d11b15" , altColor2: "#1A1919" },
        "ngpc":             { manufacturer: "snk",                  release: "1999", color: "#E92A30", altColor: "#d0161c" , altColor2: "#25374A" },
        "ngp":              { manufacturer: "snk",                  release: "1998", color: "#E92A30", altColor: "#d0161c" , altColor2: "#25374A" },
        "openbor":          { manufacturer: "pc",                   release: null,   color: "#E17930", altColor: "#c9641d" , altColor2: "#407AC0" },
        "pc":               { manufacturer: "ibm",                  release: "1981", color: "#666870", altColor: "#55575e" , altColor2: "#1F70C1" },
        "pc88":             { manufacturer: "nec",                  release: "1981", color: "#B6A781", altColor: "#ab9a6d" , altColor2: "#342B22" },
        "pc98":             { manufacturer: "nec",                  release: "1982", color: "#3B3431", altColor: "#2a2523" , altColor2: "#16643C" },
        "pce-cd":           { manufacturer: "nec",                  release: "1987", color: "#b2b2b2", altColor: "#999999" , altColor2: "#FE0000" },
        "pcengine":         { manufacturer: "nec",                  release: "1987", color: "#FE0000", altColor: "#cc0000" , altColor2: "#D9D9D9" },
        "pcfx":             { manufacturer: "nec",                  release: "1994", color: "#5C3073", altColor: "#48265a" , altColor2: "#FEC101" },
        "pet":              { manufacturer: "commodore",            release: "1977", color: "#fbfffe", altColor: "#ccfff2" , altColor2: "#2a2a2a" },
        "pico8":            { manufacturer: "lexaloffle",           release: "2015", color: "#00e436", altColor: "#00b32a" , altColor2: "#29adff" },
        "pokemini":         { manufacturer: "nintendo",             release: "2001", color: "#FCE200", altColor: "#ccb800" , altColor2: "#004F8A" },
        "ports":            { manufacturer: "pc",                   release: null,   color: "#4B77BE", altColor: "#3d66a9" , altColor2: "#36D7B7" },
        "ps2":              { manufacturer: "sony",                 release: "2000", color: "#33438A", altColor: "#293670" , altColor2: "#40A9A8" },
        "ps3":              { manufacturer: "sony",                 release: "2006", color: "#0D1114", altColor: "#000000" , altColor2: "#0095D5" },
        "psp":              { manufacturer: "sony",                 release: "2004", color: "#313131", altColor: "#1a1a1a" , altColor2: "#97A9BA" },
        "psvita":           { manufacturer: "sony",                 release: "2011", color: "#0F1012", altColor: "#000000" , altColor2: "#F9F7F7" },
        "psx":              { manufacturer: "sony",                 release: "1994", color: "#F1C002", altColor: "#caa202" , altColor2: "#252525" },
        "pv1000":           { manufacturer: "casio",                release: "1983", color: "#526b89", altColor: "#435770" , altColor2: "#da353a" },
        "residualvm":       { manufacturer: "pc",                   release: null,   color: "#cda335", altColor: "#b8912e" , altColor2: "#9ecb2e" },
        "retropie":         { manufacturer: null,                   release: null,   color: "#CB2027", altColor: "#b01c21" , altColor2: "#FEE600" },
        "rpgmaker":         { manufacturer: "pc",                   release: null,   color: "#4D603D", altColor: "#3e4e32" , altColor2: "#838382" },
        "samcoupe":         { manufacturer: "milesGordonTech",      release: "1989", color: "#2A46A5", altColor: "#253d8e" , altColor2: "#96958C" },
        "satellaview":      { manufacturer: "nintendo",             release: "1995", color: "#CD2943", altColor: "#aa2238" , altColor2: "#FFDF68" },
        "saturn":           { manufacturer: "sega",                 release: "1994", color: "#20211D", altColor: "#0d0e0c" , altColor2: "#0D7176" },
        "scummvm":          { manufacturer: "pc",                   release: null,   color: "#379742", altColor: "#297031" , altColor2: "#C26317" },
        "sega32x":          { manufacturer: "sega",                 release: "1994", color: "#212122", altColor: "#0d0e0c" , altColor2: "#F2BA5C" },
        "segacd":           { manufacturer: "sega",                 release: "1991", color: "#212122", altColor: "#0d0d0d" , altColor2: "#732A46" },
        "sfc":              { manufacturer: "nintendo",             release: "1990", color: "#007544", altColor: "#004d2d" , altColor2: "#0A2A8D" },
        "sg1000":           { manufacturer: "sega",                 release: "1983", color: "#9A2025", altColor: "#7f1a1d" , altColor2: "#BBBDBD" },
        "snes":             { manufacturer: "nintendo",             release: "1990", color: "#007544", altColor: "#004d2d" , altColor2: "#0A2A8D" },
        "snes-msu1":        { manufacturer: null,                   release: null,   color: "#A59EF7", altColor: "#7c71f4" , altColor2: "#CCCCCC" },
        "solarus":          { manufacturer: "pc",                   release: null,   color: "#e5b131", altColor: "#cc9a19" , altColor2: "#574287" },
        "steam":            { manufacturer: "valve",                release: "2003", color: "#010314", altColor: "#030730" , altColor2: "#112a40" },
        "sufami":           { manufacturer: "bandai",               release: "1996", color: "#FF0000", altColor: "#cc0000" , altColor2: "#1E2881" },
        "supergrafx":       { manufacturer: "nec",                  release: "1989", color: "#0091ad", altColor: "#006a80" , altColor2: "#000000" },
        "switch":           { manufacturer: "nintendo",             release: "2017", color: "#232323", altColor: "#0d0d0d" , altColor2: "#FE0016" },
        "ti99":             { manufacturer: "texasInstruments",     release: "1979", color: "#484141", altColor: "#363030" , altColor2: "#000000" },
        "tic80":            { manufacturer: "vadimGrigoruk",        release: "2017", color: "#4E76B4", altColor: "#456aa1" , altColor2: "#65A33D" },
        "turbografx16":     { manufacturer: "nec",                  release: "1987", color: "#333333", altColor: "#1a1a1a" , altColor2: "#F79226" },
        "turbografxcd":     { manufacturer: "nec",                  release: "1987", color: "#F79226", altColor: "#f68309" , altColor2: "#1e1c1a" },
        "uzebox":           { manufacturer: "belogicSoftware",      release: "2008", color: "#EDC63D", altColor: "#e9bb16" , altColor2: "#C9C2BF" },
        "vectrex":          { manufacturer: "smith_engineering",    release: "1982", color: "#166FC1", altColor: "#125ca1" , altColor2: "#11192E" },
        "vic20":            { manufacturer: "commodore",            release: "1980", color: "#372b1f", altColor: "#211a12" , altColor2: "#f2efde" },
        "videopac":         { manufacturer: "philips",              release: "1978", color: "#3c3a30", altColor: "#2a2922" , altColor2: "#c60000" },
        "virtualboy":       { manufacturer: "nintendo",             release: "1995", color: "#FE0016", altColor: "#cc0011" , altColor2: "#232323" },
        "wii":              { manufacturer: "nintendo",             release: "2006", color: "#005C9A", altColor: "#003d66" , altColor2: "#D1D1D1" },
        "wiiu":             { manufacturer: "nintendo",             release: "2012", color: "#3783BC", altColor: "#2e6d9e" , altColor2: "#1F9EBB" },
        "wiiware":          { manufacturer: "nintendo",             release: "2008", color: "#24A9E2", altColor: "#1a96cb" , altColor2: "#D1D1D1" },
        "win31":            { manufacturer: "microsoft_t2011",      release: "1992", color: "#c0c0c0", altColor: "#a6a6a6" , altColor2: "#000080" },
        "windows":          { manufacturer: "microsoft",            release: "1993", color: "#202020", altColor: "#0d0d0d" , altColor2: "#0078d4" },
        "wonderswan":       { manufacturer: "bandai",               release: "1999", color: "#8797A4", altColor: "#6e8191" , altColor2: "#E72835" }, 
        "wonderswancolor":  { manufacturer: "bandai",               release: "2000", color: "#162B4F", altColor: "#0b1628" , altColor2: "#EBA743" },
        "x1":               { manufacturer: "sharp",                release: "1982", color: "#752421", altColor: "#501816" , altColor2: "#28333D" },
        "x68000":           { manufacturer: "sharp",                release: "1987", color: "#3B3B3B", altColor: "#262626" , altColor2: "#838582" },
        "xbox":             { manufacturer: "microsoft_t2011",      release: "2001", color: "#8DB635", altColor: "#7b9e2e" , altColor2: "#383a37" },
        "xbox360":          { manufacturer: "microsoft_t2011",      release: "2005", color: "#97ca43", altColor: "#82b332" , altColor2: "#9d9fa2" },
        "zmachine":         { manufacturer: "infocom",              release: "1979", color: "#97ca43", altColor: "#82b332" , altColor2: "#9d9fa2" },
        "zx81":             { manufacturer: "sinclair",             release: "1981", color: "#000000", altColor: "#1a1a1a" , altColor2: "#FFFFFF" },
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
        if (event.isAutoRepeat) {
            return
        }

        if (api.keys.isPrevPage(event)) {
            event.accepted = true;
            playPage2Sound();
            if (currentMenuIndex > 0)
                currentMenuIndex--;
            return;
        }

        if (api.keys.isNextPage(event)) {
            event.accepted = true;
            playPageSound();
            if (currentMenuIndex < (dataMenu.length - 1))
                currentMenuIndex++;
            return;

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

    SoundEffect {
        id: sfxPage
        source: "assets/sounds/page.wav"
        volume: mutesfx
    }

    SoundEffect {
        id: sfxPage2
        source: "assets/sounds/page2.wav"
        volume: mutesfx
    }

    SoundEffect {
        id: sfxCollection
        source: "assets/sounds/collection.wav"
        volume: mutesfx
    }

    SoundEffect {
        id: sfxCollection2
        source: "assets/sounds/collection2.wav"
        volume: mutesfx
    }

    function playNavSound() {
        if (mutesfx === "1.0") {
            sfxNav.play();
        }
    }

    function playBackSound() {
        if (mutesfx === "1.0") {
            sfxBack.play();
        }
    }

    function playAcceptSound() {
        if (mutesfx === "1.0") {
            sfxAccept.play();
        }
    }

    function playPlaySound() {
        if (mutesfx === "1.0") {
            sfxPlay.play();
        }
    }

    function playPageSound() {
        if (mutesfx === "1.0") {
            sfxPage.play();
        }
    }

    function playPage2Sound() {
        if (mutesfx === "1.0") {
            sfxPage2.play();
        }
    }

    function playCollectionSound() {
        if (mutesfx === "1.0") {
            sfxCollection.play();
        }
    }

    function playCollection2Sound() {
        if (mutesfx === "1.0") {
            sfxCollection2.play();
        }
    }

}