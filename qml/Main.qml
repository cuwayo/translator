import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts
import Translator

ApplicationWindow {
    id: root

    width: 1440
    height: 900
    minimumWidth: 1080
    minimumHeight: 680
    visible: true
    title: qsTr("Manga Translator")

    color: "#fbf7f8"

    TranslationController {
        id: pageController
    }

    ListModel {
        id: pagesModel
    }

    FileDialog {
        id: pagePicker
        title: qsTr("Import manga page")
        nameFilters: [qsTr("Images (*.png *.jpg *.jpeg *.webp)")]

        onAccepted: {
            const pageUrl = selectedFile.toString()
            const pageName = pageUrl.substring(pageUrl.lastIndexOf("/") + 1)
            pagesModel.append({
                                  "pageName": pageName,
                                  "pageSource": pageUrl,
                                  "layerCount": qsTr("1 layer")
                              })
            pageList.currentIndex = pagesModel.count - 1
            pageController.openPage(selectedFile)
        }
    }

    header: ToolBar {
        height: 72

        background: Rectangle {
            color: "#fff8fa"
            border.color: "#f0e4e7"
            border.width: 1
        }

        contentItem: RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            spacing: 18

            Label {
                text: "◉"
                color: "#ef7187"
                font.pixelSize: 26
            }

            Repeater {
                model: [qsTr("File"), qsTr("Edit"), qsTr("Process"), qsTr("View"), qsTr("Help")]

                Label {
                    required property string modelData
                    text: modelData
                    color: "#5d5a5b"
                    font.pixelSize: 17

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }

            Item {
                Layout.fillWidth: true
            }

            Label {
                text: pageList.currentIndex >= 0
                    ? pagesModel.get(pageList.currentIndex).pageName
                    : qsTr("No page selected")
                color: "#272427"
                font.pixelSize: 18
                font.weight: Font.DemiBold
                elide: Text.ElideRight
                Layout.maximumWidth: 280
            }

            Item {
                Layout.fillWidth: true
            }

            ToolButton {
                text: "—"
                font.pixelSize: 21
            }

            ToolButton {
                text: "□"
                font.pixelSize: 20
            }

            ToolButton {
                text: "×"
                font.pixelSize: 26
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Frame {
            id: pagesPane

            Layout.preferredWidth: 264
            Layout.fillHeight: true
            padding: 18

            background: Rectangle {
                color: "#fff5f7"
                border.color: "#f0e4e7"
                border.width: 1
            }

            ColumnLayout {
                anchors.fill: parent
                spacing: 14

                RowLayout {
                    Layout.fillWidth: true

                    Label {
                        text: qsTr("Pages")
                        color: "#292628"
                        font.pixelSize: 20
                        font.weight: Font.DemiBold
                    }

                    Rectangle {
                        width: 42
                        height: 28
                        radius: 14
                        color: "#f9e8ed"

                        Label {
                            anchors.centerIn: parent
                            text: pagesModel.count
                            color: "#8a747a"
                            font.pixelSize: 14
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    ToolButton {
                        text: "+"
                        font.pixelSize: 24
                        onClicked: pagePicker.open()
                    }
                }

                TextField {
                    id: pageFilter
                    Layout.fillWidth: true
                    placeholderText: qsTr("⌕  Filter pages")
                    color: "#3d383a"

                    background: Rectangle {
                        radius: 13
                        color: "white"
                        border.color: "#dfd3d6"
                    }
                }

                ListView {
                    id: pageList

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    spacing: 10
                    model: pagesModel

                    delegate: ItemDelegate {
                        id: pageDelegate
                        required property int index
                        required property string pageName
                        required property string pageSource
                        required property string layerCount

                        width: ListView.view.width
                        height: 126
                        padding: 10
                        highlighted: ListView.isCurrentItem

                        background: Rectangle {
                            radius: 18
                            color: pageDelegate.highlighted ? "#f5dfe5" : "transparent"
                            border.color: pageDelegate.highlighted ? "#efc5d0" : "transparent"
                        }

                        contentItem: RowLayout {
                            spacing: 12

                            Rectangle {
                                Layout.preferredWidth: 62
                                Layout.preferredHeight: 96
                                radius: 8
                                color: "#eadfe1"
                                clip: true

                                Image {
                                    anchors.fill: parent
                                    anchors.margins: 2
                                    source: pageDelegate.pageSource
                                    fillMode: Image.PreserveAspectCrop
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 5

                                Label {
                                    Layout.fillWidth: true
                                    text: pageDelegate.pageName
                                    color: "#322d2f"
                                    font.pixelSize: 16
                                    font.weight: Font.DemiBold
                                    elide: Text.ElideRight
                                }

                                Label {
                                    text: pageDelegate.layerCount
                                    color: "#84767a"
                                    font.pixelSize: 14
                                }

                                Label {
                                    text: qsTr("Ready to process")
                                    color: "#84767a"
                                    font.pixelSize: 14
                                }
                            }
                        }

                        onClicked: {
                            pageList.currentIndex = index
                            pageController.openPage(pageSource)
                        }
                    }

                    Label {
                        anchors.centerIn: parent
                        width: parent.width - 36
                        visible: pagesModel.count === 0
                        text: qsTr("Import a manga page to start your archive.")
                        color: "#8a747a"
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                Button {
                    Layout.fillWidth: true
                    text: qsTr("Import page")
                    onClicked: pagePicker.open()
                }
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0

            ToolBar {
                Layout.fillWidth: true
                height: 70

                background: Rectangle {
                    color: "#ffffff"
                    border.color: "#eee9ea"
                    border.width: 1
                }

                contentItem: RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 20
                    anchors.rightMargin: 20
                    spacing: 12

                    Item {
                        Layout.fillWidth: true
                    }

                    ComboBox {
                        id: engineChoice
                        Layout.preferredWidth: 270
                        model: ["OCR and translation provider", "Offline pipeline", "Cloud pipeline"]
                    }

                    Button {
                        text: "▷  " + qsTr("Run")
                        highlighted: true
                        enabled: pageController.canTranslate
                        onClicked: {
                            pageController.targetLanguage = targetLanguage.currentText
                            pageController.translatePage()
                        }
                    }

                    ToolButton {
                        text: "⌘"
                        font.pixelSize: 21
                    }
                }
            }

            Item {
                id: canvasArea

                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                Rectangle {
                    anchors.fill: parent
                    color: "#f6f7f8"
                }

                Flickable {
                    id: pageViewport

                    anchors.fill: parent
                    anchors.margins: 32
                    contentWidth: Math.max(width, pageImage.width)
                    contentHeight: Math.max(height, pageImage.height)
                    clip: true

                    Image {
                        id: pageImage

                        x: Math.max(0, (pageViewport.width - width) / 2)
                        y: 4
                        width: pageController.canTranslate
                            ? Math.min(pageViewport.width - 120, implicitWidth)
                            : 0
                        height: pageController.canTranslate && implicitWidth > 0
                            ? width * implicitHeight / implicitWidth
                            : 0
                        source: pageController.pageUrl
                        fillMode: Image.PreserveAspectFit
                        asynchronous: true
                        smooth: true
                    }
                }

                Rectangle {
                    anchors.left: parent.left
                    anchors.leftMargin: 26
                    anchors.top: parent.top
                    anchors.topMargin: 28
                    width: 58
                    height: toolColumn.implicitHeight + 12
                    radius: 24
                    color: "white"
                    border.color: "#e8e3e5"

                    Column {
                        id: toolColumn

                        anchors.centerIn: parent
                        spacing: 2

                        Repeater {
                            model: ["⌖", "T", "╱", "◇", "⌇", "✦", "✋"]

                            ToolButton {
                                required property string modelData
                                width: 54
                                height: 52
                                text: modelData
                                font.pixelSize: modelData === "T" ? 27 : 23
                            }
                        }
                    }
                }

                Column {
                    anchors.centerIn: parent
                    spacing: 14
                    visible: !pageController.canTranslate

                    Label {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("Your manga page will appear here")
                        color: "#5f5a5c"
                        font.pixelSize: 22
                        font.weight: Font.DemiBold
                    }

                    Button {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("Import manga page")
                        onClicked: pagePicker.open()
                    }
                }

                Rectangle {
                    anchors.left: parent.left
                    anchors.leftMargin: 24
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 18
                    width: 220
                    height: 32
                    radius: 16
                    color: "#ffffff"
                    border.color: "#e5dfe1"

                    Row {
                        anchors.centerIn: parent
                        spacing: 10

                        Label {
                            text: "−"
                            color: "#60585b"
                        }

                        Rectangle {
                            width: 120
                            height: 4
                            anchors.verticalCenter: parent.verticalCenter
                            radius: 2
                            color: "#f0d3da"

                            Rectangle {
                                width: 52
                                height: parent.height
                                radius: parent.radius
                                color: "#ec7187"
                            }
                        }

                        Label {
                            text: "122%"
                            color: "#60585b"
                        }
                    }
                }
            }
        }

        Frame {
            id: inspector

            Layout.preferredWidth: 334
            Layout.fillHeight: true
            padding: 18

            background: Rectangle {
                color: "#ffffff"
                border.color: "#eee9ea"
                border.width: 1
            }

            ColumnLayout {
                anchors.fill: parent
                spacing: 16

                TabBar {
                    id: inspectorTabs
                    Layout.fillWidth: true

                    TabButton {
                        text: "☷  " + qsTr("Properties")
                    }

                    TabButton {
                        text: "♙  " + qsTr("Agent")
                    }
                }

                StackLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    currentIndex: inspectorTabs.currentIndex

                    ColumnLayout {
                        spacing: 14

                        Label {
                            text: qsTr("Text properties")
                            color: "#302c2e"
                            font.pixelSize: 19
                            font.weight: Font.DemiBold
                        }

                        Label {
                            text: qsTr("Font")
                            color: "#81777a"
                            font.pixelSize: 13
                            font.capitalization: Font.AllUppercase
                        }

                        ComboBox {
                            Layout.fillWidth: true
                            model: ["Manga Sans", "Anime Ace", "Wild Words", "System Sans"]
                        }

                        GridLayout {
                            Layout.fillWidth: true
                            columns: 2
                            columnSpacing: 12
                            rowSpacing: 8

                            Label {
                                text: qsTr("Size")
                                color: "#81777a"
                            }

                            Label {
                                text: qsTr("Weight")
                                color: "#81777a"
                            }

                            SpinBox {
                                from: 8
                                to: 144
                                value: 18
                            }

                            ComboBox {
                                model: ["Regular", "Medium", "Bold"]
                            }
                        }

                        Label {
                            text: qsTr("Output language")
                            color: "#81777a"
                            font.pixelSize: 13
                            font.capitalization: Font.AllUppercase
                        }

                        ComboBox {
                            id: targetLanguage
                            Layout.fillWidth: true
                            model: ["English", "Indonesian", "Japanese", "Spanish", "French", "German"]
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            height: 1
                            color: "#eee9ea"
                        }

                        Label {
                            text: qsTr("Layers")
                            color: "#302c2e"
                            font.pixelSize: 19
                            font.weight: Font.DemiBold
                        }

                        Repeater {
                            model: [
                                "Translated dialogue",
                                "Detected speech bubbles",
                                "Cleanup mask",
                                "Original artwork"
                            ]

                            RowLayout {
                                required property string modelData
                                Layout.fillWidth: true

                                Label {
                                    text: "T"
                                    color: "#6e6669"
                                    font.pixelSize: 18
                                }

                                Label {
                                    Layout.fillWidth: true
                                    text: modelData
                                    color: "#453f42"
                                    elide: Text.ElideRight
                                }

                                Label {
                                    text: "◉"
                                    color: "#81777a"
                                }
                            }
                        }

                        Item {
                            Layout.fillHeight: true
                        }

                        Label {
                            Layout.fillWidth: true
                            text: pageController.status
                            color: "#81777a"
                            wrapMode: Text.WordWrap
                        }
                    }

                    Label {
                        text: qsTr("The agent will guide OCR, translation, and cleanup once a provider is configured.")
                        color: "#5f5a5c"
                        wrapMode: Text.WordWrap
                        padding: 8
                    }
                }
            }
        }
    }
}
