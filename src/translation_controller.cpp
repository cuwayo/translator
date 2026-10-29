#include "translator/translation_controller.hpp"

TranslationController::TranslationController(QObject* parent) : QObject(parent) {}

auto TranslationController::targetLanguage() const -> QString { return targetLanguage_; }

void TranslationController::setTargetLanguage(const QString& targetLanguage) {
    if (targetLanguage_ == targetLanguage) {
        return;
    }

    targetLanguage_ = targetLanguage;
    emit targetLanguageChanged();
}

auto TranslationController::status() const -> QString { return status_; }

auto TranslationController::pageUrl() const -> QUrl { return pageUrl_; }

auto TranslationController::canTranslate() const -> bool { return !pageUrl_.isEmpty(); }

void TranslationController::openPage(const QUrl& pageUrl) {
    if (!pageUrl.isValid() || !pageUrl.isLocalFile()) {
        setStatus("Choose a local PNG, JPEG, or WebP manga page.");
        return;
    }

    pageUrl_ = pageUrl;
    emit pageUrlChanged();
    setStatus("Page imported. Choose the output language, then detect text.");
}

void TranslationController::translatePage() {
    if (!canTranslate()) {
        setStatus("Import a manga page before starting translation.");
        return;
    }

    setStatus("OCR and translation providers are not configured yet.");
}

void TranslationController::setStatus(const QString& status) {
    if (status_ == status) {
        return;
    }

    status_ = status;
    emit statusChanged();
}
