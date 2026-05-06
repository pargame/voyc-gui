import QtQuick

Window {
    width: cfg.windowWidth
    height: cfg.windowHeight
    visible: true
    title: "voyc-gui"
    minimumWidth: cfg.windowWidth
    minimumHeight: cfg.windowHeight
    maximumWidth: cfg.windowWidth
    maximumHeight: cfg.windowHeight

    Config {
        id: cfg
    }

    Item {
        id: popupLayer
        anchors.fill: parent
        z: cfg.popupZ
        property var activeButton: null
    }

    Rectangle {
        id: menuBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: cfg.menuBarHeight
        color: cfg.menuBarBg()

        Row {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: cfg.menuLeftMargin
            height: parent.height
            spacing: 0

            MenuButton {
                popupContainer: popupLayer
                text: "File"
                items: ["New (더미)", "Open (더미)", "Save (더미)"]
            }

            MenuButton {
                popupContainer: popupLayer
                text: "Edit"
                items: ["Undo (더미)", "Redo (더미)", "Cut (더미)", "Copy (더미)", "Paste (더미)"]
            }

            MenuButton {
                popupContainer: popupLayer
                text: "View"
                items: ["Zoom In (더미)", "Zoom Out (더미)", "Reset View (더미)"]
            }

            MenuButton {
                popupContainer: popupLayer
                text: "Settings"
                items: [cfg.isDarkMode ? "Light Mode" : "Dark Mode"]
                onItemClicked: (index) => {
                    cfg.isDarkMode = !cfg.isDarkMode;
                    items = [cfg.isDarkMode ? "Light Mode" : "Dark Mode"];
                }
            }

            MenuButton {
                popupContainer: popupLayer
                text: "Help"
                items: ["About (더미)"]
            }
        }
    }

    Rectangle {
        id: canvas
        anchors.top: menuBar.bottom
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: parent.width * cfg.canvasRatio
        color: cfg.canvasBg()

        Item {
            id: world
            anchors.fill: parent

            property real offsetX: 0
            property real offsetY: 0
            property real zoomLevel: cfg.zoomMin
            property real wheelAccumulator: 0

            function showZoomLabel() {
                zoomLabel.opacity = 1;
                zoomFadeTimer.restart();
            }

            function snap(value) {
                return Math.round(value / cfg.gridSize) * cfg.gridSize;
            }

            function toWorld(screenX, screenY) {
                return {
                    x: (screenX - width / 2 - offsetX) / zoomLevel,
                    y: (screenY - height / 2 - offsetY) / zoomLevel
                };
            }

            function toScreen(worldX, worldY) {
                return {
                    x: (worldX * zoomLevel) + width / 2 + offsetX,
                    y: (worldY * zoomLevel) + height / 2 + offsetY
                };
            }

            function zoomIn() {
                if (zoomLevel < cfg.zoomMax) {
                    zoomLevel = Math.min(cfg.zoomMax, zoomLevel + cfg.zoomStep);
                    gridCanvas.requestPaint();
                    showZoomLabel();
                }
            }

            function zoomOut() {
                if (zoomLevel > cfg.zoomMin) {
                    zoomLevel = Math.max(cfg.zoomMin, zoomLevel - cfg.zoomStep);
                    gridCanvas.requestPaint();
                    showZoomLabel();
                }
            }

            Canvas {
                id: gridCanvas
                anchors.fill: parent

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.clearRect(0, 0, width, height);

                    var grid = cfg.gridSize;

                    var visibleLeft = (-world.offsetX - world.width / 2) / world.zoomLevel;
                    var visibleRight = (-world.offsetX + world.width / 2) / world.zoomLevel;
                    var visibleTop = (-world.offsetY - world.height / 2) / world.zoomLevel;
                    var visibleBottom = (-world.offsetY + world.height / 2) / world.zoomLevel;

                    var startX = world.snap(visibleLeft) - grid;
                    var endX = world.snap(visibleRight) + grid;
                    var startY = world.snap(visibleTop) - grid;
                    var endY = world.snap(visibleBottom) + grid;

                    ctx.strokeStyle = cfg.gridColor();
                    ctx.lineWidth = cfg.gridLineWidth;

                    for (var x = startX; x <= endX; x += grid) {
                        var sx = world.toScreen(x, 0).x;
                        ctx.beginPath();
                        ctx.moveTo(sx, 0);
                        ctx.lineTo(sx, height);
                        ctx.stroke();
                    }

                    for (var y = startY; y <= endY; y += grid) {
                        var sy = world.toScreen(0, y).y;
                        ctx.beginPath();
                        ctx.moveTo(0, sy);
                        ctx.lineTo(width, sy);
                        ctx.stroke();
                    }
                }
            }

            Rectangle {
                id: snapIndicator
                width: cfg.gridSize * cfg.snapRatio * world.zoomLevel
                height: cfg.gridSize * cfg.snapRatio * world.zoomLevel
                radius: width / 2
                color: cfg.snapIndicatorColor()
                visible: false
            }

            Text {
                id: zoomLabel
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: cfg.textMargin
                text: Math.round(world.zoomLevel * 100) + "%"
                color: cfg.zoomTextColor()
                font.pixelSize: cfg.zoomFontSize
                opacity: 0

                Behavior on opacity {
                    NumberAnimation {
                        duration: cfg.fadeDuration
                        easing.type: Easing.InOutQuad
                    }
                }
            }

            Timer {
                id: zoomFadeTimer
                interval: cfg.fadeDelay
                onTriggered: zoomLabel.opacity = 0
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                property real lastX: 0
                property real lastY: 0

                onPressed: (mouse) => {
                    lastX = mouse.x;
                    lastY = mouse.y;
                }

                onPositionChanged: (mouse) => {
                    if (pressedButtons & Qt.LeftButton) {
                        world.offsetX += mouse.x - lastX;
                        world.offsetY += mouse.y - lastY;
                        lastX = mouse.x;
                        lastY = mouse.y;
                        gridCanvas.requestPaint();
                    }

                    var w = world.toWorld(mouse.x, mouse.y);
                    var sx = world.snap(w.x);
                    var sy = world.snap(w.y);
                    var sp = world.toScreen(sx, sy);

                    snapIndicator.width = cfg.gridSize * cfg.snapRatio * world.zoomLevel;
                    snapIndicator.height = cfg.gridSize * cfg.snapRatio * world.zoomLevel;
                    snapIndicator.x = sp.x - snapIndicator.width / 2;
                    snapIndicator.y = sp.y - snapIndicator.height / 2;
                    snapIndicator.visible = true;
                }

                onExited: {
                    snapIndicator.visible = false;
                }

                onWheel: (wheel) => {
                    wheel.accepted = true;
                    world.wheelAccumulator += wheel.angleDelta.y;
                    if (world.wheelAccumulator >= cfg.wheelThreshold) {
                        world.wheelAccumulator = 0;
                        world.zoomIn();
                    } else if (world.wheelAccumulator <= -cfg.wheelThreshold) {
                        world.wheelAccumulator = 0;
                        world.zoomOut();
                    }
                }
            }
        }
    }

    Rectangle {
        id: inspector
        anchors.top: menuBar.bottom
        anchors.left: canvas.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: cfg.inspectorBg()
    }
}
