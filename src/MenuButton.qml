import QtQuick

Rectangle {
    id: root
    property string text: ""
    property var items: []
    property var popupContainer: null
    signal itemClicked(int index)

    width: button.width
    height: button.height
    color: cfg.transparent()

    UiButton {
        id: button
        text: root.text
        hovered: mouseArea.containsMouse
    }

    function hidePopup() {
        popupLoader.hide();
    }

    MouseArea {
        id: mouseArea
        anchors.fill: button
        hoverEnabled: true
        onClicked: {
            if (popupContainer) {
                popupLoader.show();
            }
        }
        onEntered: {
            if (popupContainer && popupContainer.activeButton && popupContainer.activeButton !== root) {
                popupContainer.activeButton.hidePopup();
            }
        }
    }

    QtObject {
        id: popupLoader
        property var popupInstance: null

        function show() {
            hide();
            popupContainer.activeButton = root;
            popupInstance = popupComponent.createObject(popupContainer, {
                x: root.mapToItem(popupContainer, 0, root.height).x,
                y: root.mapToItem(popupContainer, 0, root.height).y,
                items: root.items,
                onItemClicked: function(index) {
                    root.itemClicked(index);
                    hide();
                }
            });
        }

        function hide() {
            if (popupInstance) {
                popupInstance.destroy();
                popupInstance = null;
            }
            if (popupContainer.activeButton === root) {
                popupContainer.activeButton = null;
            }
        }
    }

    Component {
        id: popupComponent
        Rectangle {
            property var items: []
            property var onItemClicked: null

            width: Math.max(itemColumn.maxItemWidth + cfg.menuPadding, cfg.popupMinWidth)
            height: items.length * cfg.menuBarHeight
            color: cfg.menuBarBg()
            border.color: cfg.gridColor()
            border.width: cfg.popupBorderWidth

            Column {
                id: itemColumn
                property real maxItemWidth: 0
                width: parent.width
                height: items.length * cfg.menuBarHeight

                Repeater {
                    model: parent.parent.items

                    UiButton {
                        text: modelData
                        hovered: popupMouseArea.containsMouse && popupMouseArea.isOverItem(index)
                        width: parent.width
                    }
                }
            }

            Timer {
                id: closeTimer
                interval: cfg.popupCloseDelay
                onTriggered: parent.destroy()
            }

            Timer {
                id: hoverCheckTimer
                interval: cfg.popupHoverCheckInterval
                repeat: true
                onTriggered: {
                    if (!popupMouseArea.containsMouse) {
                        closeTimer.start();
                        stop();
                    }
                }
            }

            MouseArea {
                id: popupMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onExited: closeTimer.start()
                onEntered: {
                    closeTimer.stop();
                    hoverCheckTimer.start();
                }
                onClicked: (mouse) => {
                    var idx = Math.floor(mouse.y / cfg.menuBarHeight);
                    if (idx >= 0 && idx < parent.items.length) {
                        parent.onItemClicked(idx);
                    }
                }

                function isOverItem(index) {
                    var itemTop = index * cfg.menuBarHeight;
                    var itemBottom = itemTop + cfg.menuBarHeight;
                    return mouseY >= itemTop && mouseY < itemBottom;
                }
            }
        }
    }
}
