import QtQuick

Rectangle {
    id: root
    property string text: ""
    property bool hovered: false

    width: label.width + cfg.menuPadding
    height: cfg.menuBarHeight
    color: root.hovered ? cfg.menuHoverBg() : cfg.transparent()

    Text {
        id: label
        anchors.centerIn: parent
        text: root.text
        color: cfg.menuTextColor()
        font.pixelSize: cfg.menuFontSize
    }
}
