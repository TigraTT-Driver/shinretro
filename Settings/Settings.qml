import QtQuick 2.15
import QtGraphicalEffects 1.12
import "../Global"

FocusScope {
    focus: settings.focus

    readonly property int baseItemWidth: root.width /8

    Behavior on focus {
        ParallelAnimation {
            PropertyAnimation {
                target: skew_color
                property: "width"
                from: parent.width * 0.6
                to: parent.width * 0.5
                duration: 350
            }
            PropertyAnimation {
                target: skew_color
                property: "anchors.leftMargin"
                from: parent.width *1.5
                to: parent.width * 0.23
                duration: 250
            }
        }
    }

    Rectangle {
        id: skew_color

        width: parent.width * 0.5
        height: parent.height
        antialiasing: true
        anchors {
            left: parent.left
            leftMargin: parent.width * 0.23
        }
        color: colorScheme[theme].secondary
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

    ListModel {
        id: settingsModel
        Component.onCompleted: {
            [
            [ dataText[lang].settings_general_language,  "lang",  dataText[lang].settings_general_restart,  "en,de,fr,pt" ],
            [ dataText[lang].settings_general_colorScheme,  "theme",  "",  dataText[lang].settings_general_colorScheme_Dark + "," + dataText[lang].settings_general_colorScheme_Light + "," + dataText[lang].settings_general_colorScheme_OzoneDark + "," + dataText[lang].settings_general_colorScheme_SteamOS ],
            [ dataText[lang].settings_general_music,  "music",  dataText[lang].settings_general_restart,  dataText[lang].global_no + "," + dataText[lang].global_yes ],
            [ dataText[lang].settings_general_muteSounds,  "mutesfx",  "",  dataText[lang].global_no + "," + dataText[lang].global_yes ],
            [ dataText[lang].settings_general_logoVariant,  "logoVariant",  "",  dataText[lang].settings_general_logoVariant_mono+ "," + dataText[lang].settings_general_logoVariant_color ],
            [ dataText[lang].settings_general_region,  "region",  "",  "pal,ntsc,ntscj" ],
            [ dataText[lang].settings_general_hideOSC,  "osc",  "",  dataText[lang].global_no + "," + dataText[lang].global_yes ],
            [ dataText[lang].settings_general_dynamicFontScaling,  "dynamicFontScaling",  "",  dataText[lang].global_no + "," + dataText[lang].global_yes ],
            [ dataText[lang].settings_general_OSCScheme,  "controlScheme",  "",  "Universal,Universal-JP,XBOX,PS,PS-JP" ]
            ].forEach(function(element) {
                append({
                            settingName: element[0],
                            settingKey: element[1],
                            settingSubtitle: element[2],
                            setting: element[3]
                        });
            });
        }
    }

    property var generalPage: {
        return {
            pageName: dataText[lang].settings_general,
            listmodel: settingsModel
        }
    }

    ListModel {
        id: homeSettingsModel
        Component.onCompleted: {
            [
            [ dataText[lang].settings_global_videoPlayback,  "homeVideo",  "",  dataText[lang].global_yes + "," + dataText[lang].global_no ],
            [ dataText[lang].settings_global_videoMute,  "homeVideoMute",  "",  dataText[lang].global_no + "," + dataText[lang].global_yes ]
            ].forEach(function(element) {
                append({
                            settingName: element[0],
                            settingKey: element[1],
                            settingSubtitle: element[2],
                            setting: element[3]
                        });
            });
        }
    }

    property var homePage: {
        return {
            pageName: dataText[lang].menu_home,
            listmodel: homeSettingsModel
        }
    }

    ListModel {
        id: collectionSettingsModel
        Component.onCompleted: {
            [
            [ dataText[lang].settings_collection_accentColor,  "accentColor",  "",  dataText[lang].settings_collection_accentColor_dimm + "," + dataText[lang].settings_collection_accentColor_bright ],
            [ dataText[lang].settings_collection_accentColorNr,  "accentColorNr",  "",  "2,1" ],
            [ dataText[lang].settings_collection_showAll,  "allGamesCollection",  "",  dataText[lang].global_yes + "," + dataText[lang].global_no ],
            [ dataText[lang].settings_collection_showFavorites,  "favoritesCollection",  "",  dataText[lang].global_yes + "," + dataText[lang].global_no ],
            [ dataText[lang].settings_collection_showLastPlayed,  "lastPlayedCollection",  "",  dataText[lang].global_yes + "," + dataText[lang].global_no ],
            [ dataText[lang].settings_global_videoPlayback,  "collectionVideo",  "",  dataText[lang].global_yes + "," + dataText[lang].global_no ],
            [ dataText[lang].settings_global_videoMute,  "collectionVideoMute",  "",  dataText[lang].global_no + "," + dataText[lang].global_yes ]
            ].forEach(function(element) {
                append({
                            settingName: element[0],
                            settingKey: element[1],
                            settingSubtitle: element[2],
                            setting: element[3]
                        });
            });
        }
    }

    property var collectionPage: {
        return {
            pageName: dataText[lang].menu_collections,
            listmodel: collectionSettingsModel
        }
    }

    ListModel {
        id: gameSettingsModel
        Component.onCompleted: {
            [
            [ dataText[lang].settings_games_layout,  "gamesLayout",  "",  "BoxArt-Grid,Screenshot-Grid" ],
            [ dataText[lang].settings_games_gridItemsPerRow,  "gamesGridIPR",  "",  "4,5,6,2,3" ],
            [ dataText[lang].settings_games_gridItemsViewableRows,  "gamesGridVR",  "",  "1,2,3,4,5,dynamic" ],
            [ dataText[lang].settings_global_videoPlayback,  "gamesVideo",  "",  dataText[lang].global_yes + "," + dataText[lang].global_no ],
            [ dataText[lang].settings_global_videoMute,  "gamesVideoMute",  "",  dataText[lang].global_no + "," + dataText[lang].global_yes ]
            ].forEach(function(element) {
                append({
                            settingName: element[0],
                            settingKey: element[1],
                            settingSubtitle: element[2],
                            setting: element[3]
                        });
            });
        }
    }

    property var gamePage: {
        return {
            pageName: dataText[lang].menu_games,
            listmodel: gameSettingsModel
        }
    }

    property var settingsArr: [generalPage, homePage, collectionPage, gamePage]

    property real itemheight: vpx(50)



    ListView {
    id: pagelist
    
        focus: true
        anchors {
            top: parent.top
            topMargin: vpx(40)
            bottom: parent.bottom
            left: parent.left
        }
        width: vpx(300)
        model: settingsArr
        delegate: Component {
        id: pageDelegate
        
            Item {
            id: pageRow

                property bool selected: ListView.isCurrentItem

                width: ListView.view.width
                height: itemheight

                // Page name
                Text {
                id: pageNameText
                
                    text: modelData.pageName
                    font {
                        family: global.fonts.condensed
                        italic: true
                        weight: Font.Bold
                        capitalization: Font.AllUppercase
                        pixelSize: vpx(22  * fontScalingFactor)
                    }
                    color: colorScheme[theme].text
                    verticalAlignment: Text.AlignVCenter
                    opacity: selected ? 1 : 0.2

                    width: contentWidth
                    height: parent.height
                    anchors {
                        left: parent.left; leftMargin: vpx(50)
                    }
                }
            }
        } 

        Keys.onUpPressed: { sfxNav.play(); decrementCurrentIndex() }
        Keys.onDownPressed: { sfxNav.play(); incrementCurrentIndex() }
        Keys.onPressed: {
            // Accept
            if (api.keys.isAccept(event) && !event.isAutoRepeat) {
                event.accepted = true;
                playNavSound();
                settingsList.focus = true;
            }
            // Back
            if (api.keys.isCancel(event) && !event.isAutoRepeat) {
                event.accepted = true;
                currentMenuIndex = 1;
            }
        }

    }

    ListView {
    id: settingsList

        model: settingsArr[pagelist.currentIndex].listmodel
        delegate: settingsDelegate
        
        anchors {
            top: parent.top
            topMargin: vpx(40)
            bottom: parent.bottom
            left: pagelist.right
            right: parent.right
        }
        width: vpx(500)

        spacing: vpx(0)
        orientation: ListView.Vertical

        preferredHighlightBegin: settingsList.height / 2 - itemheight
        preferredHighlightEnd: settingsList.height / 2
        highlightRangeMode: ListView.ApplyRange
        highlightMoveDuration: 100
        clip: false

        Component {
        id: settingsDelegate
        
            Item {
            id: settingRow

                property bool selected: ListView.isCurrentItem && settingsList.focus
                property variant settingList: setting.split(',')
                property int savedIndex: api.memory.get(settingKey + 'Index') || 0

                function saveSetting() {
                    api.memory.set(settingKey + 'Index', savedIndex);
                    api.memory.set(settingKey, settingList[savedIndex]);
                }

                function nextSetting() {
                    if (savedIndex != settingList.length -1)
                        savedIndex++;
                    else
                        savedIndex = 0;
                }

                function prevSetting() {
                    if (savedIndex > 0)
                        savedIndex--;
                    else
                        savedIndex = settingList.length -1;
                }

                width: ListView.view.width
                height: itemheight

                // Setting name
                Text {
                id: settingNameText
                
                    text: settingSubtitle != "" ? settingName + " " + settingSubtitle + ": " : settingName + ": "
                    color: colorScheme[theme].text
                    font {
                        family: global.fonts.condensed
                        pixelSize: vpx(20  * fontScalingFactor)
                    }
                    verticalAlignment: Text.AlignVCenter
                    opacity: selected ? 1 : 0.2

                    width: contentWidth
                    height: parent.height
                    anchors {
                        left: parent.left; leftMargin: vpx(40)
                    }
                }
                // Setting value
                Text { 
                id: settingtext; 
                
                    text: settingList[savedIndex]; 
                    color: colorScheme[theme].accent
                    font {
                        family: global.fonts.condensed
                        pixelSize: vpx(20  * fontScalingFactor)
                    }
                    verticalAlignment: Text.AlignVCenter
                    opacity: selected ? 1 : 0.2

                    height: parent.height
                    anchors {
                        right: parent.right; rightMargin: vpx(40)
                    }
                }

                Rectangle {
                    anchors { 
                        left: parent.left
                        leftMargin: vpx(25)
                        right: parent.right
                        rightMargin: vpx(25)
                        bottom: parent.bottom
                    }
                    color: colorScheme[theme].text
                    opacity: selected ? 0.1 : 0
                    height: vpx(1)
                }

                // Input handling
                // Next setting
                Keys.onRightPressed: {
                    playAcceptSound();
                    nextSetting();
                    saveSetting();
                }
                // Previous setting
                Keys.onLeftPressed: {
                    playAcceptSound();
                    prevSetting();
                    saveSetting();
                }

                Keys.onPressed: {
                    // Accept
                    if (api.keys.isAccept(event) && !event.isAutoRepeat) {
                        event.accepted = true;
                        playAcceptSound();
                        nextSetting();
                        saveSetting();
                    }
                    // Back
                    if (api.keys.isCancel(event) && !event.isAutoRepeat) {
                        event.accepted = true;
                        playNavSound();
                        pagelist.focus = true;
                    }
                }
            }
        }

        Keys.onUpPressed: {
            playNavSound(); 
            decrementCurrentIndex() 
        }

        Keys.onDownPressed: {
            playNavSound();
            incrementCurrentIndex()
        }
    }
    // Buttons
    Row {
        visible: osc === 0
        anchors {
            bottom: parent.bottom 
            bottomMargin: vpx(40)
            right: parent.right
            rightMargin: parent.width * 0.05
        }
        spacing: vpx(20)

        Controls {
            id: button_D

            message: dataText[lang].global_select
            text_color: colorScheme[theme].accepted
            front_color: colorScheme[theme].accepted.replace(/#/g, "#33");
            back_color: colorScheme[theme].accepted.replace(/#/g, "#33");
            input_button: osdScheme[controlScheme].BTND
        }

        Controls {
            id: button_R

            message: dataText[lang].global_back

            text_color: colorScheme[theme].cancel
            front_color: colorScheme[theme].cancel.replace(/#/g, "#26");
            back_color: colorScheme[theme].cancel.replace(/#/g, "#26");
            input_button: osdScheme[controlScheme].BTNR
        }
    }
}
