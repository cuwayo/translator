import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts
import Translator

ApplicationWindow {
    id: root

    width: 1120
    height: 740
    minimumWidth: 820
    minimumHeight: 600
    visible: true
    title: qsTr("Manga Translator")

    color: "#111827"

    TranslationController {
        id: pageController
    }

    FileDialog {
        id: pagePicker
        title: qsTr("Choose a manga page")
        nameFilters: [qsTr("Images (*.png *.jpg *.jpeg *.webp)")]

        onAccepted: pageController.openPage(selectedFile)
    }

    header: ToolBar {
        contentItem: RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 28
            anchors.rightMargin: 28

            Label {
                text: qsTr("Manga Translator")
                color: "#f9fafb"
                font.pixelSize: 22
                font.weight: Font.DemiBold
            }

            Label {
                text: qsTr("Local page workflow")
                color: "#94a3b8"
            }

            Item {
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("Import page")
                onClicked: pagePicker.open()
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 28
        spacing: 18

        Label {
            text: qsTr("Translate manga without losing the page layout")
            color: "#f9fafb"
            font.pixelSize: 30
            font.weight: Font.DemiBold
        }

        Label {
            text: qsTr("1. Import a page   2. Detect text regions   3. Review translations   4. Export")
            color: "#94a3b8"
            font.pixelSize: 16
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 18

            Frame {
                Layout.fillWidth: true
                Layout.fillHeight: true
                padding: 0

                background: Rectangle {
                    color: "#1f2937"
                    radius: 12
                    border.color: "#334155"
                }

                Item {
                    anchors.fill: parent

                    Image {
                        anchors.fill: parent
                        anchors.margins: 12
                        asynchronous: true
                        cache: false
                        fillMode: Image.PreserveAspectFit
                        source: pageController.pageUrl
                        visible: pageController.canTranslate
                    }

                    Column {
                        anchors.centerIn: parent
                        spacing: 12
                        visible: !pageController.canTranslate

                        Label {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: qsTr("No manga page selected")
                            color: "#e2e8f0"
                            font.pixelSize: 20
                        }

                        Button {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: qsTr("Choose image")
                            onClicked: pagePicker.open()
                        }
                    }
                }
            }

            Frame {
                Layout.preferredWidth: 340
                Layout.fillHeight: true
                padding: 20

                background: Rectangle {
                    color: "#1f2937"
                    radius: 12
                    border.color: "#334155"
                }

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 16

                    Label {
                        text: qsTr("Translation settings")
                        color: "#f9fafb"
                        font.pixelSize: 20
                        font.weight: Font.DemiBold
                    }

                    Label {
                        text: qsTr("Translate detected text to")
                        color: "#cbd5e1"
                    }

                    ComboBox {
                        id: targetLanguage
                        Layout.fillWidth: true
                        model: ["English", "Indonesian", "Japanese", "Spanish", "French", "German"]
                    }

                    Button {
                        Layout.fillWidth: true
                        text: qsTr("Detect and translate")
                        enabled: pageController.canTranslate
                        highlighted: true

                        onClicked: {
                            pageController.targetLanguage = targetLanguage.currentText
                            pageController.translatePage()
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        height: 1
                        color: "#334155"
                    }

                    Label {
                        text: qsTr("Next")
                        color: "#f9fafb"
                        font.weight: Font.DemiBold
                    }

                    Label {
                        Layout.fillWidth: true
                        text: qsTr("Detected speech bubbles and translations will appear here for review.")
                        color: "#94a3b8"
                        wrapMode: Text.WordWrap
                    }

                    Item {
                        Layout.fillHeight: true
                    }

                    Button {
                        Layout.fillWidth: true
                        text: qsTr("Export translated page")
                        enabled: false
                    }
                }
            }
        }

        Label {
            Layout.fillWidth: true
            text: pageController.status
            color: "#94a3b8"
            elide: Text.ElideRight
        }
    }
}
