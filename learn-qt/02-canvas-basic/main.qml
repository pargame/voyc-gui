import QtQuick

Window {
    width: 800
    height: 600
    visible: true
    title: "Canvas Basic"

    Canvas {
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            // 사각형
            ctx.fillStyle = "steelblue";
            ctx.fillRect(50, 50, 100, 80);

            // 원
            ctx.beginPath();
            ctx.arc(250, 90, 40, 0, 2 * Math.PI);
            ctx.fillStyle = "coral";
            ctx.fill();

            // 선
            ctx.beginPath();
            ctx.moveTo(350, 50);
            ctx.lineTo(450, 130);
            ctx.strokeStyle = "seagreen";
            ctx.lineWidth = 4;
            ctx.stroke();

            // 텍스트
            ctx.fillStyle = "black";
            ctx.font = "20px sans-serif";
            ctx.fillText("Canvas Drawing", 50, 180);
        }
    }
}
