import QtQuick

Window {
    width: 800
    height: 600
    visible: true
    title: "Mouse Event"

    Rectangle {
        anchors.fill: parent
        color: "#f0f0f0"

        Text {
            id: info
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 10
            text: "Click or move mouse"
            font.pixelSize: 16
        }

        Rectangle {
            id: marker
            width: 20
            height: 20
            radius: 10
            color: "crimson"
            visible: false
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onClicked: (mouse) => {
                marker.x = mouse.x - marker.width / 2;
                marker.y = mouse.y - marker.height / 2;
                marker.visible = true;
                info.text = "Clicked at (" + Math.round(mouse.x) + ", " + Math.round(mouse.y) + ")";
            }

            onPositionChanged: (mouse) => {
                info.text = "Mouse at (" + Math.round(mouse.x) + ", " + Math.round(mouse.y) + ")";
            }

            onPressed: (mouse) => {
                marker.color = "gold";
            }

            onReleased: (mouse) => {
                marker.color = "crimson";
            }
        }
    }
}
