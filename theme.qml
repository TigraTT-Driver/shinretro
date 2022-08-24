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
            textlight: "white",
            textdark: "#202333",
            accent: "#757BA0",
            accentalt:"#7981A8",
            accentlight: "#757BA0",
            accentdark:"#4D5167",
            icons: "white",
            favorite: "#F3C03B",
            accepted: "#8E63EC",
            cancel: "#E06C9A",
            details: "#F3C03B",
            filters: "#66D2EC",
            sorters: "#8E63EC"
        },
         "Light": {
            main: "white",
            secondary: "#EBEBEB",
            background: "white",
            text: "black",
            textalt: "#2C2C2C",
            textlight: "white",
            textdark: "black",
            accent: "#10AEBE",
            accentalt:"#2D2D2D",
            accentlight: "#10AEBE",
            accentdark:"#0E7882",
            icons: "black",
            favorite: "#CC8F00",
            accepted: "#00991E",
            cancel: "#E6140D",
            details: "#1C2C98",
            filters: "#996B00",
            sorters: "#00991E"
        },
        "OzoneDark": {
            main: "#2D2D2D",
            secondary: "#333333",
            background: "#2D2D2D",
            text: "white",
            textalt: "#9F9FA1",
            textlight: "white",
            textdark: "black",
            accent: "#00D9AE",
            accentalt:"white",
            accentlight: "#00D9AE",
            accentdark:"#00896E",
            icons: "white",
            favorite: "#F3C03B",
            accepted: "#996B00",
            cancel: "#E6140D",
            details: "#00991E",
            filters: "#5365DF",
            sorters: "#F3C03B"
        },
        "SteamOS": {
            main: "black",
            secondary: "#0E141B",
            background: "#2B2F38",
            text: "white",
            textalt: "#EBEBEB",
            textlight: "white",
            textdark: "black",
            accent: "#1A9FFF",
            accentalt:"white",
            accentlight: "#1A9FFF",
            accentdark:"#1470B2",
            icons: "white",
            favorite: "#CC8F00",
            accepted: "#EBEBEB",
            cancel: "#EBEBEB",
            details: "#EBEBEB",
            filters: "#EBEBEB",
            sorters: "#EBEBEB"
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
            global_noMultiplayer: "No multiplayer games",
            global_switch: "SWITCH",
            global_collCategory: "COLLECTION CATEGORY",
            collection_all: "All",
            collection_favorites: "Favorites",
            collection_lastplayed: "Last Played",
            collectionDetails_gamesAvailable: "games available",
            games_na: "N/A",
            games_developedBy: "Developed by",
            games_for: "for",
            games_players: "PLAYERS",
            games_player: "1 PLAYER",
            games_favorited: "FAVORITED",
            games_arcadeport: "Arcade Port",
            games_withoutDescription: "without description",
            games_removeFavorite: "REMOVE <b>FAVORITE</b>",
            games_addFavorite: "ADD <b>FAVORITE</b>",
            games_filtered: "<b>FILTERS</b>",
            games_filterMultiplayer: "Multiplayer",
            games_filter: "FILTERS",
            games_sortedBy: "SORTED BY",
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
            settings_collection_showFavorites: 'Show "Favorites" collection',
            settings_collection_showLastPlayed: 'Show "Last Played" collection',
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
            global_noMultiplayer: "Keine Mehrspieler Spiele",
            global_switch: "SCHALTER",
            global_collCategory: "SAMMLUNGSKATEGORIE",
            collection_all: "Alle",
            collection_favorites: "Favoriten",
            collection_lastplayed: "Zuletzt gespielt",
            collectionDetails_gamesAvailable: "Spiele verfügbar",
            games_na: "K.A.",
            games_developedBy: "Entwickelt von",
            games_for: "zum",
            games_players: "SPIELER",
            games_player: "1 SPIELER",
            games_favorited: "FAVORISIERT",
            games_arcadeport: "Arcade-Port",
            games_withoutDescription: "ohne Beschreibung",
            games_removeFavorite: "<b>FAVORIT</b> entfernen",
            games_addFavorite: "<b>FAVORIT</b> hinzufügen",
            games_filtered: "<b>FILTER</b>",
            games_filterMultiplayer: "Mehrspieler",
            games_filter: "FILTER",
            games_sortedBy: "SORTIERT NACH",
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
            settings_collection_showFavorites: 'Sammlung "Favoriten" anzeigen',
            settings_collection_showLastPlayed: 'Sammlung "Zuletzt gespielt" anzeigen',
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
            global_noMultiplayer: "Aucun jeu multijoueur",
            global_switch: "CHANGER",
            global_collCategory: "CATÉGORIE DE COLLECTE",
            collection_all: "Tous",
            collection_favorites: "Favoris",
            collection_lastplayed: "Dernier joué",
            collectionDetails_gamesAvailable: "Jeux disponibles",
            games_na: "NC",
            games_developedBy: "Developpé par",
            games_for: "pour",
            games_players: "JOUEURS",
            games_player: "1 JOUEUR",
            games_favorited: "FAVORIS",
            games_arcadeport: "Port d'arcade",
            games_withoutDescription: "sans description",
            games_removeFavorite: "RETIRER DES <b>FAVORIS</b>",
            games_addFavorite: "AJOUTER AUX <b>FAVORIS</b>",
            games_filtered: "<b>FILTRES</b>",
            games_filterMultiplayer: "Multijoueur",
            games_filter: "FILTRES",
            games_sortedBy: "TRIÉ PAR",
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
            settings_collection_showFavorites: 'Afficher la collection "Favoris"',
            settings_collection_showLastPlayed: 'Afficher la collection "Dernière lecture"',
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
            global_noMultiplayer: "Sem jogos multijogador",
            global_switch: "TROCAR",
            global_collCategory: "CATEGORIA DE COLEÇÃO",
            collection_all: "Todos",
            collection_favorites: "Favoritos",
            collection_lastplayed: "Jogou pela última vez",
            collectionDetails_gamesAvailable: "Jogos disponíveis",
            games_na: "N/A",
            games_developedBy: "Desenvolvido por",
            games_for: "por",
            games_players: "JOGADORES",
            games_player: "1 JOGADOR",
            games_favorited: "FAVORITO",
            games_arcadeport: "Porto Arcade",
            games_withoutDescription: "sem descrição",
            games_removeFavorite: "REMOVER <b>FAVORITO</b>",
            games_addFavorite: "ADICIONAR <b>FAVORITO</b>",
            games_filtered: "<b>FILTROS</b>",
            games_filterMultiplayer: "Multijogador",
            games_sortedBy: "ORDENADO POR",
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
            settings_collection_showFavorites: 'Mostrar coleção "Favoritos"',
            settings_collection_showLastPlayed: 'Mostrar coleção "Últimas jogadas"',
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
    property var favoritesCollection: api.memory.get('favoritesCollectionIndex') || 0
    property var lastPlayedCollection: api.memory.get('lastPlayedCollectionIndex') || 0
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
        var collections = api.collections.toVarArray()
        if (favoritesCollection != "1") {
            collections.unshift({"name": dataText[lang].collection_favorites, "shortName": "favorites", "games": allFavorites, "extra": {"collectiontype": "System"}});
        }
        if (lastPlayedCollection != "1") {
            collections.unshift({"name": dataText[lang].collection_lastplayed, "shortName": "lastplayed", "games": lastPlayed, "extra": {"collectiontype": "System"}});
        }
        if (allGamesCollection != "1") {
            collections.unshift({"name": dataText[lang].collection_all, "shortName": "all", "games": api.allGames, "extra": {"collectiontype": "System"}});
        }
        collections = collections.filter(systemCollection);
        return collections
    }

    property var collectionType: api.memory.get("currentCollectionType") || "System"
    property var collectionTypes: getAllCollectionTypes()

    property int currentCollectionIndex: api.memory.get("currentCollectionIndex-" + collectionType) || 0
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

    property variant dataManufacturers: {
        "acorn":               { color: "#FFFFFF" },
        "amstrad":             { color: "#FFFFFF" },
        "apf":                 { color: "#FFFFFF" },
        "apple":               { color: "#FFFFFF" },
        "atari":               { color: "#FFFFFF" },
        "bally":               { color: "#FFFFFF" },
        "bandai":              { color: "#FFFFFF" },
        "belogic":             { color: "#FFFFFF" },
        "bitcorp":             { color: "#FFFFFF" },
        "capcom":              { color: "#FFFFFF" },
        "casio":               { color: "#FFFFFF" },
        "cdproject":           { color: "#FFFFFF" },
        "coleco":              { color: "#FFFFFF" },
        "commodore":           { color: "#FFFFFF" },
        "dragonData":          { color: "#FFFFFF" },
        "entex":               { color: "#FFFFFF" },
        "fairchild":           { color: "#FFFFFF" },
        "fujitsu":             { color: "#FFFFFF" },
        "ibm":                 { color: "#FFFFFF" },
        "infocom":             { color: "#FFFFFF" },
        "lexaloffle":          { color: "#FFFFFF" },
        "mattel":              { color: "#FFFFFF" },
        "microsoft":           { color: "#FFFFFF" },
        "nec":                 { color: "#2E1D81" },
        "nintendo":            { color: "#E11919" },
        "panasonic":           { color: "#FFFFFF" },
        "pc":                  { color: "#FFFFFF" },
        "philips":             { color: "#FFFFFF" },
        "sammy":               { color: "#FFFFFF" },
        "sega":                { color: "#17569b" },
        "sharp":               { color: "#FFFFFF" },
        "sinclair":            { color: "#FFFFFF" },
        "smitheng":            { color: "#FFFFFF" },
        "snk":                 { color: "#359CD2" },
        "sony":                { color: "#1D1D1D" },
        "tandy":               { color: "#FFFFFF" },
        "ti":                  { color: "#FFFFFF" },
        "thomson":             { color: "#FFFFFF" },
        "valve":               { color: "#010314" },
        "vadimGrigoruk":       { color: "#FFFFFF" }
    }

    // Additional data to display manufacturers and release dates
    property variant dataConsoles: {
        "default":            { manufacturer: null,            release: null,   color: "#000000", altColor: "#252525", altColor2: "#FFFFFF", fullName: "Default"   },
        "all":                { manufacturer: null,            release: null,   color: "#851740", altColor: "#6D1234", altColor2: "#364792", fullName: "All Games"   },
        "lastplayed":         { manufacturer: null,            release: null,   color: "#FFFFFF", altColor: "#FFFFFF", altColor2: "#FFFFFF", fullName: "Last Played"   },
        "favorites":          { manufacturer: null,            release: null,   color: "#FFFFFF", altColor: "#FFFFFF", altColor2: "#FFFFFF", fullName: "Favorites"   },
        "3do":                { manufacturer: "panasonic",     release: "1993", color: "#0000A0", altColor: "#000080", altColor2: "#FFE41B", fullName: "3DO"   },
        "3ds":                { manufacturer: "nintendo",      release: "2011", color: "#C02424", altColor: "#961D1D", altColor2: "#929497", fullName: "Nintendo 3DS"   },
        "64dd":               { manufacturer: "nintendo",      release: "1999", color: "#233387", altColor: "#1A2765", altColor2: "#238B41", fullName: "Nintendo 64DD"   },
        "adam":               { manufacturer: "coleco",        release: "1983", color: "#A4DDF0", altColor: "#7BCEEA", altColor2: "#F3994B", fullName: "Coleco Adam"   },
        "amiga":              { manufacturer: "commodore",     release: "1985", color: "#192753", altColor: "#121B3B", altColor2: "#ED2224", fullName: "Amiga"   },
        "amiga600":           { manufacturer: "commodore",     release: "1992", color: "#192753", altColor: "#121B3B", altColor2: "#ED2224", fullName: "Amiga 600"   },
        "amiga1200":          { manufacturer: "commodore",     release: "1992", color: "#ED2224", altColor: "#D41114", altColor2: "#192753", fullName: "Amiga 1200"   },
        "amigacd32":          { manufacturer: "commodore",     release: "1993", color: "#FF5853", altColor: "#FF3A33", altColor2: "#4A9BE4", fullName: "Amiga CD32"   },
        "amigacdtv":          { manufacturer: "commodore",     release: "1991", color: "#C86388", altColor: "#BD426F", altColor2: "#F62717", fullName: "Amiga CDTV"   },
        "amstradcpc":         { manufacturer: "amstrad",       release: "1984", color: "#942647", altColor: "#7A1F3A", altColor2: "#00A651", fullName: "Amstrad CPC"   },
        "android":            { manufacturer: null,            release: null,   color: "#77C159", altColor: "#5CA83E", altColor2: "#478230", fullName: "Android"   },
        "apfm1000":           { manufacturer: "apf",           release: "1978", color: "#9A5F41", altColor: "#7E4D35", altColor2: "#373632", fullName: "APF M-1000"   },
        "apple2":             { manufacturer: "apple",         release: "1977", color: "#009DDC", altColor: "#0080B3", altColor2: "#61BB46", fullName: "Apple II"   },
        "apple2gs":           { manufacturer: "apple",         release: "1986", color: "#D27C35", altColor: "#BC6B29", altColor2: "#8C3E8C", fullName: "Apple IIGS"   },
        "arcade":             { manufacturer: null,            release: null,   color: "#FCE236", altColor: "#FBDA04", altColor2: "#5D9EED", fullName: "Arcade"   },
        "arcade-mame":        { manufacturer: null,            release: null,   color: "#D00E2D", altColor: "#9B071E", altColor2: "#FFFFFF", fullName: "Arcade"  },
        "arcade-neogeo":      { manufacturer: null,            release: null,   color: "#D00E2D", altColor: "#9B071E", altColor2: "#FFFFFF", fullName: "Arcade"  },
        "arcade-naomi":       { manufacturer: null,            release: null,   color: "#D00E2D", altColor: "#9B071E", altColor2: "#FFFFFF", fullName: "Arcade"  },
        "arcade-naomi2":      { manufacturer: null,            release: null,   color: "#D00E2D", altColor: "#9B071E", altColor2: "#FFFFFF", fullName: "Arcade"  },
        "arcade-fbneo":       { manufacturer: null,            release: null,   color: "#D00E2D", altColor: "#9B071E", altColor2: "#FFFFFF", fullName: "Arcade"  },
        "arcade-atomiswave":  { manufacturer: null,            release: null,   color: "#D00E2D", altColor: "#9B071E", altColor2: "#FFFFFF", fullName: "Arcade"  },
        "arcade-model2":      { manufacturer: null,            release: null,   color: "#D00E2D", altColor: "#9B071E", altColor2: "#FFFFFF", fullName: "Arcade"  },
        "arcade-model3":      { manufacturer: null,            release: null,   color: "#D00E2D", altColor: "#9B071E", altColor2: "#FFFFFF", fullName: "Arcade"  },
        "arcade-stv":         { manufacturer: null,            release: null,   color: "#D00E2D", altColor: "#9B071E", altColor2: "#FFFFFF", fullName: "Arcade"  },
        "arcade-taito":       { manufacturer: null,            release: null,   color: "#D00E2D", altColor: "#9B071E", altColor2: "#FFFFFF", fullName: "Arcade"  },
        "arcade-teknoparrot": { manufacturer: null,            release: null,   color: "#D00E2D", altColor: "#9B071E", altColor2: "#FFFFFF", fullName: "Arcade"  },
        "astrocade":          { manufacturer: "bally",         release: "1978", color: "#D27C35", altColor: "#CCA300", altColor2: "#9A5F41", fullName: "Bally Astrocade"  },
        "atari800":           { manufacturer: "atari",         release: "1979", color: "#B6B896", altColor: "#9FA276", altColor2: "#EBD335", fullName: "Atari 800"  },
        "atari2600":          { manufacturer: "atari",         release: "1977", color: "#C1272A", altColor: "#941E20", altColor2: "#1C267D", fullName: "Atari 2600"  },
        "atari5200":          { manufacturer: "atari",         release: "1982", color: "#1C6EB8", altColor: "#175E9B", altColor2: "#973E3A", fullName: "Atari 5200"  },
        "atari7800":          { manufacturer: "atari",         release: "1986", color: "#333333", altColor: "#1A1A1A", altColor2: "#AA2C39", fullName: "Atari 7800"  },
        "atarijaguar":        { manufacturer: "atari",         release: "1993", color: "#232326", altColor: "#0C0C0D", altColor2: "#FF0000", fullName: "Atari Jaguar"  },
        "atarijaguarcd":      { manufacturer: "atari",         release: "1995", color: "#FF0000", altColor: "#CC0000", altColor2: "#232326", fullName: "Atari Jaguar CD"  },
        "atarilynx":          { manufacturer: "atari",         release: "1989", color: "#262626", altColor: "#0D0D0D", altColor2: "#F38900", fullName: "Atari Lynx"  }, 
        "atarist":            { manufacturer: "atari",         release: "1985", color: "#357BB7", altColor: "#2E6A9E", altColor2: "#949494", fullName: "Atari ST"  },
        "atarixe":            { manufacturer: "atari",         release: "1987", color: "#AB9BA6", altColor: "#978290", altColor2: "#250D16", fullName: "Atari XEGS"  },
        "atomiswave":         { manufacturer: "sammy",         release: "2003", color: "#FF6B00", altColor: "#CC5500", altColor2: "#029205", fullName: "Arcade"  },
        "bbcmicro":           { manufacturer: "acorn",         release: "1981", color: "#1C0B0A", altColor: "#000000", altColor2: "#26250E", fullName: "BBC Micro"  },
        "c128":               { manufacturer: "commodore",     release: "1985", color: "#BBAD93", altColor: "#A79472", altColor2: "#FD4120", fullName: "Commodore 128"  },
        "c64":                { manufacturer: "commodore",     release: "1982", color: "#968971", altColor: "#847862", altColor2: "#FD4120", fullName: "Commodore 64"  },
        "cdi":                { manufacturer: "philips",       release: "1991", color: "#1E0A0A", altColor: "#000000", altColor2: "#1F0B0B", fullName: "Philips CDi"  },
        "channelf":           { manufacturer: "fairchild",     release: "1976", color: "#E0E0E0", altColor: "#CCCCCC", altColor2: "#4B3FF3", fullName: "Fairchild Channel F"  },
        "coco":               { manufacturer: "tandy",         release: "1980", color: "#93A3B3", altColor: "#798CA0", altColor2: "#3A3B40", fullName: "Tandy TRS-80"  },
        "colecovision":       { manufacturer: "coleco",        release: "1982", color: "#EF8185", altColor: "#EA6166", altColor2: "#A4DDF0", fullName: "ColecoVision"  },
        "cplus4":             { manufacturer: "commodore",     release: "1983", color: "#BBAD93", altColor: "#A79472", altColor2: "#00A0C6", fullName: "Commodore Plus/4"  },
        "cps1":               { manufacturer: "capcom",        release: "1988", color: "#000000", altColor: "#252525", altColor2: "#252525", fullName: "Arcade"  },
        "cps2":               { manufacturer: "capcom",        release: "1993", color: "#000000", altColor: "#252525", altColor2: "#252525", fullName: "Arcade"  },
        "cps3":               { manufacturer: "capcom",        release: "1996", color: "#000000", altColor: "#252525", altColor2: "#252525", fullName: "Arcade"  },
        "daphne":             { manufacturer: null,            release: null,   color: "#856125", altColor: "#63481C", altColor2: "#DEBA27", fullName: "Daphne"  },
        "dos":                { manufacturer: "ibm",           release: "1981", color: "#666870", altColor: "#55575E", altColor2: "#1F70C1", fullName: "DOS"  },
        "dragon32":           { manufacturer: "dragonData",    release: "1982", color: "#F50019", altColor: "#CC0014", altColor2: "#74B719", fullName: "Dragon 32"  },
        "dreamcast":          { manufacturer: "sega",          release: "1998", color: "#C1C3C2", altColor: "#B1B4B3", altColor2: "#3E649F", fullName: "Sega Dreamcast"  },
        "famicom":            { manufacturer: "nintendo",      release: "1983", color: "#AA1C41", altColor: "#841533", altColor2: "#C0A987", fullName: "Famicom"  },
        "fba":                { manufacturer: null,            release: null,   color: "#231F20", altColor: "#0E0C0C", altColor2: "#FE7B07", fullName: "Arcade"  },
        "fbneo":              { manufacturer: null,            release: null,   color: "#FF8200", altColor: "#CC6900", altColor2: "#FFDBA1", fullName: "Arcade"  },
        "fds":                { manufacturer: "nintendo",      release: "1986", color: "#A71636", altColor: "#87122B", altColor2: "#C7AF89", fullName: "Famicom Disk System"  },
        "fmtowns":            { manufacturer: "fujitsu",       release: "1989", color: "#DFE0DF", altColor: "#CBCDCB", altColor2: "#8C8C8B", fullName: "FM Towns"  },
        "gamate":             { manufacturer: "bitcorp",       release: "1990", color: "#FFFC6D", altColor: "#FFFC4D", altColor2: "#464A53", fullName: "Gamate"  },
        "gameandwatch":       { manufacturer: "nintendo",      release: "1980", color: "#7B0000", altColor: "#4D0000", altColor2: "#FFFFFF", fullName: "Nintendo Game & Watch"  },
        "gamegear":           { manufacturer: "sega",          release: "1990", color: "#212122", altColor: "#0D0D0D", altColor2: "#0000FE", fullName: "Game Gear"  },
        "gba":                { manufacturer: "nintendo",      release: "2001", color: "#280FBE", altColor: "#1F0B8E", altColor2: "#5C67A9", fullName: "Game Boy Advance"  },
        "gbc":                { manufacturer: "nintendo",      release: "1998", color: "#2D308E", altColor: "#252774", altColor2: "#7642B6", fullName: "Game Boy Color"  },
        "gb":                 { manufacturer: "nintendo",      release: "1989", color: "#2D308E", altColor: "#252774", altColor2: "#9B2063", fullName: "Game Boy"  },
        "gamecube":           { manufacturer: "nintendo",      release: "2001", color: "#524C82", altColor: "#3D3960", altColor2: "#7B79AA", fullName: "Nintendo GameCube"  },
        "genesis":            { manufacturer: "sega",          release: "1988", color: "#212122", altColor: "#0D0D0D", altColor2: "#181C4E", fullName: "Sega Genesis"  },
        "gog":                { manufacturer: "cdproject",     release: "2008", color: "#1D1D1D", altColor: "#0D0D0D", altColor2: "#6D1D72", fullName: "GOG"  },
        "gx4000":             { manufacturer: "amstrad",       release: "1990", color: "#9E4968", altColor: "#7A3850", altColor2: "#DBD9D4", fullName: "Amstrad GX4000"  },
        "intellivision":      { manufacturer: "mattel",        release: "1979", color: "#2B201D", altColor: "#0F0B0A", altColor2: "#D4C1A0", fullName: "Intellivision"  },
        "kodi":               { manufacturer: null,            release: null,   color: "#186AAC", altColor: "#125287", altColor2: "#36A2CD", fullName: "Kodi"  },
        "linux":              { manufacturer: null,            release: null,   color: "#EBC40C", altColor: "#C2A30A", altColor2: "#141413", fullName: "Linux"  },
        "macintosh":          { manufacturer: "apple",         release: "1984", color: "#76B845", altColor: "#609438", altColor2: "#009DDD", fullName: "Apple MacIntosh"  },
        "mame":               { manufacturer: null,            release: null,   color: "#231F20", altColor: "#0E0C0C", altColor2: "#00ADEF", fullName: "MAME"  },
        "mastersystem":       { manufacturer: "sega",          release: "1985", color: "#165193", altColor: "#113D6F", altColor2: "#E60000", fullName: "Sega Master System"  },
        "megadrive":          { manufacturer: "sega",          release: "1988", color: "#20211D", altColor: "#0D0E0C", altColor2: "#DCE3E6", fullName: "Sega Mega Drive"  },
        "moto":               { manufacturer: "thomson",       release: "1986", color: "#E6F0EF", altColor: "#CFE2E0", altColor2: "#4F8E5C", fullName: "Thomson MOTO"  },
        "msx2":               { manufacturer: "microsoft",     release: "1985", color: "#B7B7B7", altColor: "#A6A6A6", altColor2: "#7C3036", fullName: "MSX2"  },
        "msx":                { manufacturer: "microsoft",     release: "1983", color: "#9D9B91", altColor: "#878578", altColor2: "#89283b", fullName: "MSX"  },
        "msxturbor":          { manufacturer: "panasonic",     release: "1990", color: "#637080", altColor: "#4E5865", altColor2: "#99784b", fullName: "MSX Turbo-R"  },
        "n64":                { manufacturer: "nintendo",      release: "1996", color: "#238B41", altColor: "#19662F", altColor2: "#233387", fullName: "Nintendo 64"  },
        "naomi":              { manufacturer: "sega",          release: "1998", color: "#C75433", altColor: "#A2442A", altColor2: "#E4E7D7", fullName: "Arcade"  },
        "naomi2":             { manufacturer: "sega",          release: "2000", color: "#C75433", altColor: "#A2442A", altColor2: "#E4E7D7", fullName: "Arcade"  },
        "naomigd":            { manufacturer: "sega",          release: "1998", color: "#243551", altColor: "#182335", altColor2: "#E4E7D7", fullName: "Arcade"  },
        "nds":                { manufacturer: "nintendo",      release: "2004", color: "#BCBCBC", altColor: "#A6A6A6", altColor2: "#212121", fullName: "Nintendo DS"  },
        "neogeocd":           { manufacturer: "snk",           release: "1994", color: "#24241E", altColor: "#0E0E0C", altColor2: "#FFD400", fullName: "Neo Geo CD"  },
        "neogeo":             { manufacturer: "snk",           release: "1990", color: "#2D2D2D", altColor: "#1A1A1A", altColor2: "#BF9328", fullName: "Neo Geo"  },
        "nes":                { manufacturer: "nintendo",      release: "1983", color: "#EA2C27", altColor: "#D11B15", altColor2: "#1A1919", fullName: "Nintendo Entertainment System"  },
        "ngpc":               { manufacturer: "snk",           release: "1999", color: "#E92A30", altColor: "#D0161C", altColor2: "#25374A", fullName: "Neo Geo Pocket Color"  },
        "ngp":                { manufacturer: "snk",           release: "1998", color: "#E92A30", altColor: "#D0161C", altColor2: "#25374A", fullName: "Neo Geo Pocket"  },
        "openbor":            { manufacturer: null,            release: null,   color: "#E17930", altColor: "#C9641d", altColor2: "#407AC0", fullName: "Open BOR"  },
        "pc":                 { manufacturer: "ibm",           release: "1981", color: "#666870", altColor: "#55575E", altColor2: "#1F70C1", fullName: "PC"  },
        "pc88":               { manufacturer: "nec",           release: "1981", color: "#B6A781", altColor: "#AB9A6D", altColor2: "#342B22", fullName: "NEC PC-88"  },
        "pc98":               { manufacturer: "nec",           release: "1982", color: "#3B3431", altColor: "#2A2523", altColor2: "#16643C", fullName: "NEC PC-98"  },
        "pce-cd":             { manufacturer: "nec",           release: "1987", color: "#B2B2B2", altColor: "#999999", altColor2: "#FE0000", fullName: "PC Engine CD"  },
        "pcengine":           { manufacturer: "nec",           release: "1987", color: "#FE0000", altColor: "#CC0000", altColor2: "#D9D9D9", fullName: "PC Engine"  },
        "pcfx":               { manufacturer: "nec",           release: "1994", color: "#5C3073", altColor: "#48265A", altColor2: "#FEC101", fullName: "PC-FX"  },
        "pet":                { manufacturer: "commodore",     release: "1977", color: "#FBFFFE", altColor: "#CCFFF2", altColor2: "#2A2A2A", fullName: "Commodore PET"  },
        "pico8":              { manufacturer: "lexaloffle",    release: "2015", color: "#00E436", altColor: "#00B32A", altColor2: "#29ADFF", fullName: "PICO-8"  },
        "pokemini":           { manufacturer: "nintendo",      release: "2001", color: "#FCE200", altColor: "#CCB800", altColor2: "#004F8A", fullName: "Pokemon Mini"  },
        "ports":              { manufacturer: null,            release: null,   color: "#4B77BE", altColor: "#3D66A9", altColor2: "#36D7B7", fullName: "PC"  },
        "ps2":                { manufacturer: "sony",          release: "2000", color: "#33438A", altColor: "#293670", altColor2: "#40A9A8", fullName: "PS2"  },
        "ps3":                { manufacturer: "sony",          release: "2006", color: "#0D1114", altColor: "#000000", altColor2: "#0095D5", fullName: "PS3"  },
        "psp":                { manufacturer: "sony",          release: "2004", color: "#313131", altColor: "#1A1A1A", altColor2: "#97A9BA", fullName: "PSP"  },
        "pspminis":           { manufacturer: "sony",          release: "2004", color: "#313131", altColor: "#1A1A1A", altColor2: "#97A9BA", fullName: "PSP Minis"  },
        "psvita":             { manufacturer: "sony",          release: "2011", color: "#0F1012", altColor: "#000000", altColor2: "#F9F7F7", fullName: "PS Vita"  },
        "psx":                { manufacturer: "sony",          release: "1994", color: "#F1C002", altColor: "#CAA202", altColor2: "#252525", fullName: "PlayStation"  },
        "pv1000":             { manufacturer: "casio",         release: "1983", color: "#526B89", altColor: "#435770", altColor2: "#DA353A", fullName: "Casio PV-1000"  },
        "residualvm":         { manufacturer: null,            release: null,   color: "#CDA335", altColor: "#B8912E", altColor2: "#9ECB2E", fullName: "PC"  },
        "retropie":           { manufacturer: null,            release: null,   color: "#CB2027", altColor: "#B01C21", altColor2: "#FEE600", fullName: "RetroPie"  },
        "rpgmaker":           { manufacturer: null,            release: null,   color: "#4D603D", altColor: "#3E4E32", altColor2: "#838382", fullName: "PC"  },
        "satellaview":        { manufacturer: "nintendo",      release: "1995", color: "#CD2943", altColor: "#AA2238", altColor2: "#FFDF68", fullName: "Nintendo SatellaView"  },
        "saturn":             { manufacturer: "sega",          release: "1994", color: "#20211D", altColor: "#0D0E0C", altColor2: "#0D7176", fullName: "Sega Saturn"  },
        "scummvm":            { manufacturer: null,            release: null,   color: "#379742", altColor: "#297031", altColor2: "#C26317", fullName: "PC"  },
        "sega32x":            { manufacturer: "sega",          release: "1994", color: "#212122", altColor: "#0D0E0C", altColor2: "#F2BA5C", fullName: "Sega 32X"  },
        "segacd":             { manufacturer: "sega",          release: "1991", color: "#212122", altColor: "#0D0D0D", altColor2: "#732A46", fullName: "Sega CD"  },
        "sfc":                { manufacturer: "nintendo",      release: "1990", color: "#007544", altColor: "#004D2D", altColor2: "#0A2A8D", fullName: "Super Famicom"  },
        "sg1000":             { manufacturer: "sega",          release: "1983", color: "#9A2025", altColor: "#7F1A1D", altColor2: "#BBBDBD", fullName: "Sega SG-1000"  },
        "snes":               { manufacturer: "nintendo",      release: "1990", color: "#007544", altColor: "#004D2D", altColor2: "#0A2A8D", fullName: "Super Nintendo"  },
        "solarus":            { manufacturer: null,            release: null,   color: "#E5B131", altColor: "#CC9A19", altColor2: "#574287", fullName: "Solarus"  },
        "steam":              { manufacturer: null,            release: null,   color: "#010314", altColor: "#030730", altColor2: "#112A40", fullName: "Steam"  },
        "sufami":             { manufacturer: "bandai",        release: "1996", color: "#FF0000", altColor: "#CC0000", altColor2: "#1E2881", fullName: "SuFami Turbo"  },
        "sgfx":               { manufacturer: "nec",           release: "1989", color: "#0091AD", altColor: "#006A80", altColor2: "#000000", fullName: "SuperGrafx"  },
        "switch":             { manufacturer: "nintendo",      release: "2017", color: "#232323", altColor: "#0D0D0D", altColor2: "#FE0016", fullName: "Nintendo Switch"  },
        "ti99":               { manufacturer: "ti",            release: "1979", color: "#484141", altColor: "#363030", altColor2: "#000000", fullName: "TI-99"  },
        "tic80":              { manufacturer: "vadimGrigoruk", release: "2017", color: "#4E76B4", altColor: "#456AA1", altColor2: "#65A33D", fullName: "TIC-80"  },
        "turbografx16":       { manufacturer: "nec",           release: "1987", color: "#333333", altColor: "#1A1A1A", altColor2: "#F79226", fullName: "TurboGrafx 16"  },
        "turbografxcd":       { manufacturer: "nec",           release: "1987", color: "#F79226", altColor: "#F68309", altColor2: "#1E1C1A", fullName: "TurboGrafx CD"  },
        "uzebox":             { manufacturer: "belogic",       release: "2008", color: "#EDC63D", altColor: "#E9BB16", altColor2: "#C9C2BF", fullName: "Uzebox"  },
        "vectrex":            { manufacturer: "smitheng",      release: "1982", color: "#166FC1", altColor: "#125CA1", altColor2: "#11192E", fullName: "Vectrex"  },
        "vic20":              { manufacturer: "commodore",     release: "1980", color: "#372B1F", altColor: "#211A12", altColor2: "#F2EFDE", fullName: "Commodore VIC-20"  },
        "videopac":           { manufacturer: "philips",       release: "1978", color: "#3C3A30", altColor: "#2A2922", altColor2: "#C60000", fullName: "Magnavox Odyssey 2"  },
        "virtualboy":         { manufacturer: "nintendo",      release: "1995", color: "#FE0016", altColor: "#CC0011", altColor2: "#232323", fullName: "Virtual Boy"  },
        "wii":                { manufacturer: "nintendo",      release: "2006", color: "#005C9A", altColor: "#003D66", altColor2: "#D1D1D1", fullName: "Nintendo Wii"  },
        "wiiu":               { manufacturer: "nintendo",      release: "2012", color: "#3783BC", altColor: "#2E6D9E", altColor2: "#1F9EBB", fullName: "Nintendo Wii U"  },
        "wiiware":            { manufacturer: "nintendo",      release: "2008", color: "#24A9E2", altColor: "#1A96CB", altColor2: "#D1D1D1", fullName: "Nintendo WiiWare"  },
        "win31":              { manufacturer: "microsoft",     release: "1992", color: "#C0C0C0", altColor: "#A6A6A6", altColor2: "#000080", fullName: "Windows 3.1"  },
        "windows":            { manufacturer: "microsoft",     release: "1993", color: "#202020", altColor: "#0D0D0D", altColor2: "#0078D4", fullName: "Windows"  },
        "wswan":              { manufacturer: "bandai",        release: "1999", color: "#8797A4", altColor: "#6E8191", altColor2: "#E72835", fullName: "Bandai WonderSwan"  },
        "wswanc":             { manufacturer: "bandai",        release: "2000", color: "#162B4F", altColor: "#0B1628", altColor2: "#EBA743", fullName: "Bandai WonderSwan Color"  },
        "x1":                 { manufacturer: "sharp",         release: "1982", color: "#752421", altColor: "#501816", altColor2: "#28333D", fullName: "Sharp X1"  },
        "x68000":             { manufacturer: "sharp",         release: "1987", color: "#3B3B3B", altColor: "#262626", altColor2: "#838582", fullName: "Sharp X68000"  },
        "xbla":               { manufacturer: "microsoft",     release: "2005", color: "#97CA43", altColor: "#82B332", altColor2: "#9D9FA2", fullName: "Xbox Live Arcade"  },
        "xbox":               { manufacturer: "microsoft",     release: "2001", color: "#8DB635", altColor: "#7B9E2E", altColor2: "#383A37", fullName: "Xbox"  },
        "xbox360":            { manufacturer: "microsoft",     release: "2005", color: "#97CA43", altColor: "#82B332", altColor2: "#9D9FA2", fullName: "Xbox 360"  },
        "zmachine":           { manufacturer: "infocom",       release: "1979", color: "#97CA43", altColor: "#82B332", altColor2: "#9D9FA2", fullName: "Z-machine"  },
        "zx81":               { manufacturer: "sinclair",      release: "1981", color: "#000000", altColor: "#1A1A1A", altColor2: "#FFFFFF", fullName: "ZX81"  },
        "zxspectrum":         { manufacturer: "sinclair",      release: "1982", color: "#D6A763", altColor: "#CF974A", altColor2: "#000000", fullName: "ZX Spectrum"  }
    }

    // Define Last Played and Favorites collections
    SortFilterProxyModel {
        id: allFavorites
        sourceModel: api.allGames
        filters: ValueFilter { roleName: "favorite"; value: true; }
    }

    SortFilterProxyModel {
        id: lastPlayedBase
        sourceModel: api.allGames
        sorters: RoleSorter { roleName: "lastPlayed"; sortOrder: Qt.DescendingOrder; }
    }

    SortFilterProxyModel {
        id: lastPlayed
        sourceModel: lastPlayedBase
        filters: IndexFilter { maximumIndex: 49; }
    }

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

        if (api.keys.isFilters(event)) {
            var index = collectionTypes.indexOf(collectionType) + 1;
            collectionType = (index < collectionTypes.length) ? collectionTypes[index] : collectionTypes[0];
            currentCollectionIndex = api.memory.get("currentCollectionIndex-" + collectionType) || 0;
            games.currentGameIndex = 0;
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

    function saveCurrentCollectionState(collectionType, currentCollectionIndex) {
        api.memory.set("currentCollectionType", collectionType);
        api.memory.set("currentCollectionIndex-" + collectionType, currentCollectionIndex);
    }

    function saveCurrentState(currentGameIndex, sortIndex) {
        api.memory.set("currentMenuIndex", currentMenuIndex);
        api.memory.set("currentCollectionType", collectionType);
        api.memory.set("currentCollectionIndex-" + collectionType, currentCollectionIndex);
        if (sortIndex !== undefined) {
            api.memory.set('sortIndex', sortIndex);
        }
        if (currentGameIndex !== undefined) {
            api.memory.set(collectionType + "-" + currentCollectionIndex + "-currentGameIndex", currentGameIndex);
        }
    }

    function systemCollection(coll) {
        if (coll.extra.collectiontype != undefined) {
            return coll.extra.collectiontype.toString() == collectionType;
        } else {
            return true;
        }
    }

    function getAllCollectionTypes() {
        var types = ['System'];
        var collections = api.collections.toVarArray().forEach(function(value, index, array) {
                if (value.extra.collectiontype != undefined) {
                    types.push(value.extra.collectiontype.toString());
                }
            }
        );
        return Array.from(new Set(types));
    }

    function lightenDarkenColor(col,amt) {
        var usePound = false;
        if (col[0] == "#") {
            col = col.slice(1);
            usePound = true;
        }

        var num = parseInt(col, 16);
        var r = (num >> 16) + amt;
        if (r > 255) r = 255;
        else if (r < 0) r = 0;

        var b = ((num >> 8) & 0x00FF) + amt;
        if (b > 255) b = 255;
        else if (b < 0) b = 0;

        var g = (num & 0x0000FF) + amt;
        if (g > 255) g = 255;
        else if (g < 0) g = 0;

        return (usePound ? "#" : "") + (g | (b << 8) | (r << 16)).toString(16);
    }

    function lightOrDark(color) {
        // Variables for red, green, blue values
        var r, g, b, hsp;

        // Check the format of the color, HEX or RGB?
        if (color.match(/^rgb/)) {
            // If RGB --> store the red, green, blue values in separate variables
            color = color.match(/^rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d+(?:\.\d+)?))?\)$/);
            r = color[1];
            g = color[2];
            b = color[3];
        } else {
            // If hex --> Convert it to RGB: http://gist.github.com/983661
            color = +("0x" + color.slice(1).replace(color.length < 5 && /./g, '$&$&'));
            r = color >> 16;
            g = color >> 8 & 255;
            b = color & 255;
        }

        // HSP (Highly Sensitive Poo) equation from http://alienryderflex.com/hsp.html
        hsp = Math.sqrt(
            0.299 * (r * r) +
            0.587 * (g * g) +
            0.114 * (b * b)
        );

        // Using the HSP value, determine whether the color is light or dark
        if (hsp > 127.5) {
            return 'light';
        } else {
            return 'dark';
        }
    }

}
