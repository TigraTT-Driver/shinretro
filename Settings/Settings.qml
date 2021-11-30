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
            left: parent.left; leftMargin: parent.width * 0.23
        }
        color: theme.secondary
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
        ListElement {
            settingName: "Language"
            settingKey: "lang"
            settingSubtitle: "-WIP-"
            setting: "English"
        }
        ListElement {
            settingName: "Color Scheme"
            settingKey: "theme"
            settingSubtitle: ""
            setting: "themeDark,themeLight"
        }
        ListElement {
            settingName: "Mute Sounds"
            settingKey: "mutesfx"
            settingSubtitle: ""
            setting: "No,Yes"
        }
        ListElement {
            settingName: "Logo Variant"
            settingKey: "logoVariant"
            settingSubtitle: ""
            setting: "mono,color"
        }
        ListElement {
            settingName: "Hide Controls"
            settingKey: "osc"
            settingSubtitle: ""
            setting: "No,Yes"
        }
        ListElement {
            settingName: "Controls Scheme"
            settingKey: "controlScheme"
            settingSubtitle: ""
            setting: "Universal,XBOX,PS"
        }
    }

    property var generalPage: {
        return {
            pageName: "General",
            listmodel: settingsModel
        }
    }

    ListModel {
        id: homeSettingsModel
        ListElement {
            settingName: "Video Playback"
            settingKey: "homeVideo"
            settingSubtitle: ""
            setting: "Yes,No"
        }
        ListElement {
            settingName: "Mute Video"
            settingKey: "homeVideoMute"
            settingSubtitle: ""
            setting: "No,Yes"
        }
    }

    property var homePage: {
        return {
            pageName: "Home Screen",
            listmodel: homeSettingsModel
        }
    }

        ListModel {
        id: collectionSettingsModel
        ListElement {
            settingName: "Accent Color"
            settingKey: "accentColor"
            settingSubtitle: "-WIP-"
            setting: "dimm,bright"
        }
    }

    property var collectionPage: {
        return {
            pageName: "Collection Screen",
            listmodel: collectionSettingsModel
        }
    }

    ListModel {
        id: gameSettingsModel
        ListElement {
            settingName: "Games Layout"
            settingKey: "gamesLayout"
            settingSubtitle: "-WIP-"
            setting: "BoxArt-Grid"
        }
        ListElement {
            settingName: "Video Playback"
            settingKey: "gamesVideo"
            settingSubtitle: ""
            setting: "Yes,No"
        }
        ListElement {
            settingName: "Mute Video"
            settingKey: "gamesVideoMute"
            settingSubtitle: ""
            setting: "No,Yes"
        }
    }

    property var gamePage: {
        return {
            pageName: "Game Screen",
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
            topMargin: vpx(40);
            bottom: parent.bottom; //bottomMargin: helpMargin
            left: parent.left; //leftMargin: globalMargin
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
                        pixelSize: vpx(22)
                    }
                    color: theme.text
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
                sfxNav.play();
                settingsList.focus = true;
            }
            // Back
            if (api.keys.isCancel(event) && !event.isAutoRepeat) {
                event.accepted = true;
                currentMenuIndex = 1
            }
        }

    }

    ListView {
    id: settingsList

        model: settingsArr[pagelist.currentIndex].listmodel
        delegate: settingsDelegate
        
        anchors {
            top: parent.top;
            topMargin: vpx(40);
            bottom: parent.bottom; 
            left: pagelist.right; //leftMargin: globalMargin
            right: parent.right; //rightMargin: globalMargin
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
                    color: theme.text
                    font {
                        family: global.fonts.condensed
                        pixelSize: vpx(20)
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
                    color: theme.accent
                    font {
                        family: global.fonts.condensed
                        pixelSize: vpx(20)
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
                        left: parent.left; leftMargin: vpx(25)
                        right: parent.right; rightMargin: vpx(25)
                        bottom: parent.bottom
                    }
                    color: theme.text
                    opacity: selected ? 0.1 : 0
                    height: vpx(1)
                }

                // Input handling
                // Next setting
                Keys.onRightPressed: {
                    sfxAccept.play()
                    nextSetting();
                    saveSetting();
                }
                // Previous setting
                Keys.onLeftPressed: {
                    sfxAccept.play();
                    prevSetting();
                    saveSetting();
                }

                Keys.onPressed: {
                    // Accept
                    if (api.keys.isAccept(event) && !event.isAutoRepeat) {
                        event.accepted = true;
                        sfxAccept.play()
                        nextSetting();
                        saveSetting();
                    }
                    // Back
                    if (api.keys.isCancel(event) && !event.isAutoRepeat) {
                        event.accepted = true;
                        sfxNav.play()
                        pagelist.focus = true;
                    }
                }
            }
        } 

        Keys.onUpPressed: { sfxNav.play(); decrementCurrentIndex() }
        Keys.onDownPressed: { sfxNav.play(); incrementCurrentIndex() }
    }
    // Buttons
    Row {
        visible: osc === "No"
        anchors {
            bottom: parent.bottom; bottomMargin: vpx(40)
            right: parent.right
            rightMargin: parent.width * 0.05
        }
        spacing: vpx(20)

        Controls {
            id: button_D

            message: "OK"
            text_color: theme.accepted
            front_color: theme.accepted.replace(/#/g, "#33");
            back_color: theme.accepted.replace(/#/g, "#33");
            input_button: "BTN-D"
        }

        Controls {
            id: button_R

            message: "GO <b>BACK</b>"

            text_color: theme.cancel
            front_color: theme.cancel.replace(/#/g, "#26");
            back_color: theme.cancel.replace(/#/g, "#26");
            input_button: "BTN-R"
        }
    }
}