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
    property int popupZ: 1000
    property int gridLineWidth: 1
    property int popupBorderWidth: 1
    property int popupItemLeftMargin: 12
    property int fadeDuration: 200
    property int fadeDelay: 800
    property int popupMinWidth: 100
    property int popupCloseDelay: 300
    property int popupHoverCheckInterval: 100

    function menuBarBg() { return isDarkMode ? "#252526" : "#faf6f1"; }
    function menuTextColor() { return isDarkMode ? "#cccccc" : "#4a4a4a"; }
    function menuHoverBg() { return isDarkMode ? "#3c3c3c" : "#f0e6d8"; }
    function transparent() { return "transparent"; }
    function canvasBg() { return isDarkMode ? "#2d2d2d" : "#fffdf9"; }
    function gridColor() { return isDarkMode ? "#3a3a3a" : "#e8e0d5"; }
    function inspectorBg() { return isDarkMode ? "#1e1e1e" : "#f5efe8"; }
    function snapIndicatorColor() { return isDarkMode ? "#555" : "#c4b8a8"; }
    function zoomTextColor() { return isDarkMode ? "#888" : "#a09080"; }
}
