import QtQuick 2.15
import QtGraphicalEffects 1.12
import "../Global"

FocusScope {
    focus: collections.focus

    readonly property int baseItemWidth: root.width /8
    readonly property var touch_color: dataConsoles[clearShortname(currentCollection.shortName)].color

    Behavior on focus {
        ParallelAnimation {
            PropertyAnimation {
                target: skew_color
                property: "width"
                from: parent.width * 0.6
                to: parent.width * 0.28
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

        width: parent.width * 0.28
        height: parent.height
        antialiasing: true
        anchors {
            left: parent.left; leftMargin: parent.width * 0.23
        }
        color: touch_color
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

    Item {
        width: parent.width
        height: parent.height * 0.58
        anchors {
            bottom: parent.bottom; bottomMargin: vpx(120)
        }

        PathView {
            id: pv_collections

            readonly property int pathLength: ( pathItemCount + 1 ) * baseItemWidth

            anchors.fill: parent

            focus: collections.focus

            // model: api.collections
            model: allCollections
            currentIndex: currentCollectionIndex

            delegate: CollectionsItems {}

            snapMode: PathView.SnapOneItem
            highlightMoveDuration: 100
            highlightRangeMode: PathView.ApplyRange

            pathItemCount: 10
            path: Path {
                startX: - baseItemWidth
                startY: pv_collections.height /2
                PathAttribute { name: "currentWidth"; value: baseItemWidth; }
                PathAttribute { name: "currentHeight"; value: pv_collections.height; }
                PathLine {
                    x: pv_collections.path.startX + pv_collections.pathLength / 3.2 - baseItemWidth * 1.5
                    y: pv_collections.path.startY
                }
                PathPercent { value: 0.32 - (2 / pv_collections.pathItemCount) / 2 }
                PathAttribute { name: "currentWidth"; value: baseItemWidth; }
                PathAttribute { name: "currentHeight"; value: pv_collections.height; }
                PathLine {
                    x: pv_collections.path.startX + pv_collections.pathLength / 3.2
                    y: pv_collections.path.startY
                }
                PathAttribute { name: "currentWidth"; value: baseItemWidth * 2; }
                PathAttribute { name: "currentHeight"; value: pv_collections.height *1.17; }
                PathLine {
                    x: pv_collections.path.startX + pv_collections.pathLength / 3.2 + baseItemWidth * 1.5
                    y: pv_collections.path.startY
                }
                PathAttribute { name: "currentWidth"; value: baseItemWidth; }
                PathAttribute { name: "currentHeight"; value: pv_collections.height; }
                PathPercent { value: 0.32 + (2 / pv_collections.pathItemCount) / 2 }
                PathLine {
                    x: pv_collections.path.startX + pv_collections.pathLength - vpx(45)
                    y: pv_collections.path.startY
                }
                PathAttribute { name: "currentWidth"; value: baseItemWidth; }
                PathAttribute { name: "currentHeight"; value: pv_collections.height; }
                PathPercent { value: 1 }
            }

            preferredHighlightBegin: 0.32
            preferredHighlightEnd: preferredHighlightBegin

            Keys.onPressed: {

                if (event.isAutoRepeat) {
                    return
                }

                if (api.keys.isAccept(event)) {

                    //Accept game sound
                    sfxAccept.play();

                    event.accepted = true;
                    currentMenuIndex = 2
                }

                if (api.keys.isCancel(event)) {
                    event.accepted = true;
                    currentMenuIndex = 0

                    //PrevPage sound
                    sfxBack.play();
                }

                if (event.key == Qt.Key_Left) {

                    //navigation sound
                    sfxNav.play();

                    event.accepted = true;
                    if (currentCollectionIndex <= 0)
                        if (event.isAutoRepeat)
                            currentCollectionIndex = 0
                        else
                            currentCollectionIndex = allCollections.length - 1
                    else
                        currentCollectionIndex--;
                        api.memory.set("currentCollectionIndex", currentCollectionIndex)
                }

                if (event.key == Qt.Key_Right) {

                    //navigation sound
                    sfxNav.play();

                    event.accepted = true;

                    if (currentCollectionIndex >= allCollections.length - 1)
                        if (event.isAutoRepeat)
                            currentCollectionIndex = allCollections.length - 1;
                        else
                            currentCollectionIndex = 0;
                    else
                        currentCollectionIndex++;
                        api.memory.set("currentCollectionIndex", currentCollectionIndex)
                }
            }
        }
    }

    PathView {
        id: pv_collections_logo

        width: parent.width * 0.59
        height: parent.height * 0.5
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
        }

        clip: true
        currentIndex: currentCollectionIndex
        // model: api.collections
        model: allCollections
        delegate: CollectionsDetails {}

        pathItemCount: 3
        path: Path {

            // Horizontal Left to Right
            startX: -pv_collections_logo.width
            startY: pv_collections_logo.height /2

            PathLine {
                x: pv_collections_logo.path.startX + pv_collections_logo.width *3
                y: pv_collections_logo.path.startY
            }

        }

        interactive: false
        highlightMoveDuration: 150
        highlightRangeMode: PathView.ApplyRange
        snapMode: PathView.SnapOneItem

        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
    }

    Text {
        color: theme.text
        anchors {
            right: parent.right; rightMargin: vpx(35)
            top: parent.top; topMargin: vpx(160)
        }
        text: (currentCollectionIndex+1)+"/"+pv_collections.count
        font {
            family: robotoSlabThin.name
            pixelSize: vpx(16)
        }
    }

    // Bottons
    Row {
        anchors {
            bottom: parent.bottom; bottomMargin: vpx(40)
            right: parent.right
            rightMargin: parent.width * 0.05
        }
        spacing: vpx(20)

        Controls {
            id: button_D

            message: "<b>"+currentCollection.name+"</b> GAMES"
            text_color: theme.accepted
            front_color: "#338E63EC"
            back_color: "#338E63EC"
            input_button: "BTN-D"
        }

        Controls {
            id: button_R

            message: "GO <b>BACK</b>"

            text_color: theme.cancel
            front_color: "#26E06C9A"
            back_color: "#26E06C9A"
            input_button: "BTN-R"
        }
    }
}