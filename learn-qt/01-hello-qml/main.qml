import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: "Hello QML"

    Text {
        anchors.centerIn: parent
        text: "Hello, Qt Quick!"
        font.pixelSize: 32
    }
}
