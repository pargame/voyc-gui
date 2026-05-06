import QtQuick

QtObject {
    property int windowWidth: 1280
    property int windowHeight: 720
    property int menuBarHeight: 28
    property real canvasRatio: 0.7
    property int gridSize: 20
    property real zoomMin: 1.0
    property real zoomMax: 2.0
    property real zoomStep: 0.1
    property int wheelThreshold: 60
    property real snapRatio: 0.6

    property bool isDarkMode: true

    property int menuPadding: 24
    property int menuLeftMargin: 8
    property int menuFontSize: 13
    property int zoomFontSize: 12
    property int textMargin: 8

    function menuBarBg() { return isDarkMode ? "#252526" : "#f3f3f3"; }
    function menuTextColor() { return isDarkMode ? "#cccccc" : "#333333"; }
    function menuHoverBg() { return isDarkMode ? "#3c3c3c" : "#e5e5e5"; }
    function transparent() { return "transparent"; }
    function canvasBg() { return isDarkMode ? "#2d2d2d" : "#ffffff"; }
    function gridColor() { return isDarkMode ? "#3a3a3a" : "#e0e0e0"; }
    function inspectorBg() { return isDarkMode ? "#1e1e1e" : "#f5f5f5"; }
    function snapIndicatorColor() { return isDarkMode ? "#555" : "#aaa"; }
    function zoomTextColor() { return isDarkMode ? "#888" : "#666"; }
}
