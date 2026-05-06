import QtQuick

Window {
    width: 1200
    height: 800
    visible: true
    title: "voyc-gui"

    Rectangle {
        anchors.fill: parent
        color: "#1e1e1e"

        Text {
            anchors.centerIn: parent
            text: "voyc-gui"
            color: "white"
            font.pixelSize: 48
        }
    }
}
