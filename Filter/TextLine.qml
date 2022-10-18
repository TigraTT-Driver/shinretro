import QtQuick 2.15


FocusScope {
    id: root

    property int fontSize
    property alias text: textInput.text
    property alias textColor: textInput.color
    property alias placeholder: placeholder.text
    property alias placeholderColor: placeholder.color

    height: fontSize * 1.7
    clip: true

    Rectangle {
        anchors.fill: parent

        color: colorScheme[theme].secondary
        border.color: colorScheme[theme].secondary.replace(/#/g, "#60");
        border.width: vpx(1)
    }

    TextInput {
        id: textInput

        focus: true

        anchors.fill: parent
        anchors.leftMargin: vpx(8)
        anchors.rightMargin: vpx(8)

        verticalAlignment: Text.AlignVCenter

        color: colorScheme[theme].text
        font {
            pixelSize: root.fontSize
            family: globalFonts.sans
        }
        //virtualkeyboard
        property bool active : false //set to false by default
        Keys.onPressed: {
            event.accepted, textInput.focus, active = virtualKeyboardOnPressed(event,textInput,active);
        }
        Keys.onReleased:{
            event.accepted = virtualKeyboardOnReleased(event);
        }
    }

    Text {
        id: placeholder
        anchors.fill: parent
        anchors.leftMargin: vpx(8)
        anchors.rightMargin: vpx(8)

        verticalAlignment: Text.AlignVCenter

        color: colorScheme[theme].textalt
        font {
            pixelSize: root.fontSize
            family: glyphs.name
            italic: true
        }

        visible: !textInput.text
    }
}