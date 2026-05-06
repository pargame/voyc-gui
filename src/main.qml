import QtQuick

Window {
    width: 1280
    height: 720
    visible: true
    title: "voyc-gui"
    minimumWidth: 1280
    minimumHeight: 720
    maximumWidth: 1280
    maximumHeight: 720

    Rectangle {
        id: canvas
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width * 0.7
        color: "#2d2d2d"

        Item {
            id: world
            anchors.fill: parent

            property real offsetX: 0
            property real offsetY: 0
            property int gridSize: 20

            function snap(value) {
                return Math.round(value / gridSize) * gridSize;
            }

            function toWorld(screenX, screenY) {
                return {
                    x: screenX - width / 2 - offsetX,
                    y: screenY - height / 2 - offsetY
                };
            }

            function toScreen(worldX, worldY) {
                return {
                    x: worldX + width / 2 + offsetX,
                    y: worldY + height / 2 + offsetY
                };
            }

            Canvas {
                id: gridCanvas
                anchors.fill: parent

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.clearRect(0, 0, width, height);

                    var grid = world.gridSize;

                    var visibleLeft = -world.offsetX - world.width / 2;
                    var visibleRight = -world.offsetX + world.width / 2;
                    var visibleTop = -world.offsetY - world.height / 2;
                    var visibleBottom = -world.offsetY + world.height / 2;

                    var startX = world.snap(visibleLeft) - grid;
                    var endX = world.snap(visibleRight) + grid;
                    var startY = world.snap(visibleTop) - grid;
                    var endY = world.snap(visibleBottom) + grid;

                    ctx.strokeStyle = "#3a3a3a";
                    ctx.lineWidth = 1;

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
                width: world.gridSize * 0.6
                height: world.gridSize * 0.6
                radius: width / 2
                color: "#555"
                visible: false
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

                    snapIndicator.x = sp.x - snapIndicator.width / 2;
                    snapIndicator.y = sp.y - snapIndicator.height / 2;
                    snapIndicator.visible = true;
                }

                onExited: {
                    snapIndicator.visible = false;
                }
            }
        }
    }

    Rectangle {
        id: inspector
        anchors.left: canvas.right
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: "#1e1e1e"
    }
}
