#include "translator/translation_controller.hpp"

#include "translator/translator.hpp"

TranslationController::TranslationController(QObject* parent) : QObject(parent) {}

auto TranslationController::inputText() const -> QString { return inputText_; }

void TranslationController::setInputText(const QString& inputText) {
    if (inputText_ == inputText) {
        return;
    }

    inputText_ = inputText;
    emit inputTextChanged();
}

auto TranslationController::translatedText() const -> QString { return translatedText_; }

auto TranslationController::sourceLanguage() const -> QString { return sourceLanguage_; }

void TranslationController::setSourceLanguage(const QString& sourceLanguage) {
    if (sourceLanguage_ == sourceLanguage) {
        return;
    }

    sourceLanguage_ = sourceLanguage;
    emit sourceLanguageChanged();
}

auto TranslationController::targetLanguage() const -> QString { return targetLanguage_; }

void TranslationController::setTargetLanguage(const QString& targetLanguage) {
    if (targetLanguage_ == targetLanguage) {
        return;
    }

    targetLanguage_ = targetLanguage;
    emit targetLanguageChanged();
}

auto TranslationController::status() const -> QString { return status_; }

void TranslationController::translate() {
    if (inputText_.trimmed().isEmpty()) {
        setTranslatedText({});
        setStatus("Enter text to translate.");
        return;
    }

    setTranslatedText(QString::fromStdString(translator::translate(inputText_.toStdString())));
    setStatus("Translation provider not configured; showing the source text.");
}

void TranslationController::setTranslatedText(const QString& translatedText) {
    if (translatedText_ == translatedText) {
        return;
    }

    translatedText_ = translatedText;
    emit translatedTextChanged();
}

void TranslationController::setStatus(const QString& status) {
    if (status_ == status) {
        return;
    }

    status_ = status;
    emit statusChanged();
}
