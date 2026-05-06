import QtQuick

Window {
    width: 800
    height: 600
    visible: true
    title: "Zoom and Pan"

    Rectangle {
        anchors.fill: parent
        color: "#222"

        // 뷰포트 변환을 위한 컨테이너
        Item {
            id: viewport
            anchors.fill: parent

            property real scaleFactor: 1.0
            property real offsetX: 0
            property real offsetY: 0

            transform: [
                Scale {
                    xScale: viewport.scaleFactor
                    yScale: viewport.scaleFactor
                },
                Translate {
                    x: viewport.offsetX
                    y: viewport.offsetY
                }
            ]

            // 그리드 배경
            Canvas {
                width: 2000
                height: 2000
                x: -500
                y: -500

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.strokeStyle = "#444";
                    ctx.lineWidth = 1;

                    for (var i = 0; i <= 2000; i += 50) {
                        ctx.beginPath();
                        ctx.moveTo(i, 0);
                        ctx.lineTo(i, 2000);
                        ctx.stroke();

                        ctx.beginPath();
                        ctx.moveTo(0, i);
                        ctx.lineTo(2000, i);
                        ctx.stroke();
                    }
                }
            }

            // 배치할 오브젝트들
            Rectangle {
                x: 0; y: 0
                width: 100; height: 100
                color: "steelblue"
                radius: 8
            }

            Rectangle {
                x: 200; y: 150
                width: 120; height: 80
                color: "coral"
                radius: 8
            }

            Rectangle {
                x: -150; y: 200
                width: 80; height: 120
                color: "seagreen"
                radius: 8
            }
        }

        // 줌/팬 컨트롤
        MouseArea {
            anchors.fill: parent

            property real lastX: 0
            property real lastY: 0

            onWheel: (wheel) => {
                var delta = wheel.angleDelta.y / 120;
                var newScale = viewport.scaleFactor + delta * 0.1;
                viewport.scaleFactor = Math.max(0.2, Math.min(3.0, newScale));
            }

            onPressed: (mouse) => {
                lastX = mouse.x;
                lastY = mouse.y;
            }

            onPositionChanged: (mouse) => {
                if (pressedButtons & Qt.LeftButton) {
                    viewport.offsetX += (mouse.x - lastX) / viewport.scaleFactor;
                    viewport.offsetY += (mouse.y - lastY) / viewport.scaleFactor;
                    lastX = mouse.x;
                    lastY = mouse.y;
                }
            }
        }

        // 상태 표시
        Text {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 10
            text: "Scale: " + viewport.scaleFactor.toFixed(2) +
                  "  Offset: (" + Math.round(viewport.offsetX) + ", " + Math.round(viewport.offsetY) + ")"
            color: "white"
            font.pixelSize: 14
        }

        // 도움말
        Text {
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 10
            text: "Wheel: Zoom / Drag: Pan"
            color: "#888"
            font.pixelSize: 12
        }
    }
}
