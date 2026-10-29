import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Translator

ApplicationWindow {
    id: root

    width: 1000
    height: 680
    minimumWidth: 720
    minimumHeight: 540
    visible: true
    title: qsTr("Translator")

    color: "#f8fafc"

    TranslationController {
        id: translationController
    }

    header: ToolBar {
        contentItem: RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 28
            anchors.rightMargin: 28

            Label {
                text: qsTr("Translator")
                font.pixelSize: 22
                font.weight: Font.DemiBold
            }

            Item {
                Layout.fillWidth: true
            }

            Label {
                text: qsTr("Desktop")
                color: "#64748b"
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 28
        spacing: 16

        Label {
            text: qsTr("Translate text simply")
            font.pixelSize: 30
            font.weight: Font.DemiBold
        }

        Label {
            text: qsTr("Choose languages, enter text, and translate.")
            color: "#475569"
            font.pixelSize: 16
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            ComboBox {
                id: sourceLanguage
                Layout.preferredWidth: 200
                model: ["English", "Indonesian", "Japanese", "Spanish", "French", "German"]
                currentIndex: 0
            }

            Button {
                text: "⇄"
                Accessible.name: qsTr("Swap languages")

                onClicked: {
                    const savedIndex = sourceLanguage.currentIndex
                    sourceLanguage.currentIndex = targetLanguage.currentIndex
                    targetLanguage.currentIndex = savedIndex
                }
            }

            ComboBox {
                id: targetLanguage
                Layout.preferredWidth: 200
                model: sourceLanguage.model
                currentIndex: 1
            }

            Item {
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("Translate")
                enabled: sourceText.text.trim().length > 0
                highlighted: true

                onClicked: {
                    translationController.sourceLanguage = sourceLanguage.currentText
                    translationController.targetLanguage = targetLanguage.currentText
                    translationController.inputText = sourceText.text
                    translationController.translate()
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 16

            Frame {
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 10

                    Label {
                        text: sourceLanguage.currentText
                        font.weight: Font.DemiBold
                    }

                    TextArea {
                        id: sourceText
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        placeholderText: qsTr("Enter text to translate")
                        wrapMode: TextEdit.Wrap
                        selectByMouse: true
                    }
                }
            }

            Frame {
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 10

                    Label {
                        text: targetLanguage.currentText
                        font.weight: Font.DemiBold
                    }

                    TextArea {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        readOnly: true
                        text: translationController.translatedText
                        placeholderText: qsTr("Translation will appear here")
                        wrapMode: TextEdit.Wrap
                        selectByMouse: true
                    }
                }
            }
        }

        Label {
            Layout.fillWidth: true
            text: translationController.status
            color: "#64748b"
            elide: Text.ElideRight
        }
    }
}
