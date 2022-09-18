import QtQuick 2.15
import "qrc:/qmlutils" as PegasusUtils


FocusScope {
    id: root

    property alias withTitle: panel.withTitle
    property alias withMultiplayer: panel.withMultiplayer
    property alias withFavorite: panel.withFavorite

    signal closeRequested

    Keys.onPressed: {
        if (event.isAutoRepeat) {
            return;
        }

        if (api.keys.isCancel(event) || api.keys.isFilters(event)) {
            event.accepted = true;
            closeRequested();
        }
    }

    FilterPanel {
        id: panel
        z: 400
        focus: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom
        visible: false
    }

    states: [
        State {
            name: "open"; when: root.focus
            AnchorChanges {
                target: panel
                anchors.bottom: parent.bottom
                anchors.top: undefined
            }
        }
    ]
    transitions: [
        Transition {
            to: "open"
            onRunningChanged: {
                if (running)
                    panel.visible = true;
            }
            AnchorAnimation { duration: 200; easing.type: Easing.OutCubic }
        },
        Transition {
            from: "open"
            onRunningChanged: {
                if (!running)
                    panel.visible = false;
            }
            AnchorAnimation { duration: 200; easing.type: Easing.OutCubic }
        }
    ]

}