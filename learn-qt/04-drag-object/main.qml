import QtQuick

Window {
    width: 800
    height: 600
    visible: true
    title: "Drag Object"

    Rectangle {
        anchors.fill: parent
        color: "#f5f5f5"

        // 드래그 가능한 사각형
        Rectangle {
            id: dragRect
            width: 120
            height: 80
            x: 100
            y: 100
            color: "steelblue"
            radius: 8

            Text {
                anchors.centerIn: parent
                text: "Drag me"
                color: "white"
                font.pixelSize: 16
            }

            MouseArea {
                anchors.fill: parent
                drag.target: parent
                drag.axis: Drag.XAndYAxis

                onPressed: {
                    dragRect.color = "darkblue";
                    dragRect.z = 10;
                }

                onReleased: {
                    dragRect.color = "steelblue";
                    dragRect.z = 0;
                }
            }
        }

        // 드래그 가능한 원
        Rectangle {
            id: dragCircle
            width: 100
            height: 100
            x: 300
            y: 200
            radius: 50
            color: "coral"

            Text {
                anchors.centerIn: parent
                text: "Me too"
                color: "white"
                font.pixelSize: 14
            }

            MouseArea {
                anchors.fill: parent
                drag.target: parent
                drag.axis: Drag.XAndYAxis

                onPressed: {
                    dragCircle.color = "tomato";
                    dragCircle.z = 10;
                }

                onReleased: {
                    dragCircle.color = "coral";
                    dragCircle.z = 0;
                }
            }
        }

        // 위치 표시
        Text {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.margins: 10
            text: "Blue: (" + Math.round(dragRect.x) + ", " + Math.round(dragRect.y) +
                  ")  Coral: (" + Math.round(dragCircle.x) + ", " + Math.round(dragCircle.y) + ")"
            font.pixelSize: 14
            color: "#666"
        }
    }
}
