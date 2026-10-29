#pragma once

#include <QtQml/qqmlregistration.h>

#include <QObject>
#include <QString>
#include <QUrl>

class TranslationController final : public QObject {
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(QString targetLanguage READ targetLanguage WRITE setTargetLanguage NOTIFY
                   targetLanguageChanged)
    Q_PROPERTY(QString status READ status NOTIFY statusChanged)
    Q_PROPERTY(QUrl pageUrl READ pageUrl NOTIFY pageUrlChanged)
    Q_PROPERTY(bool canTranslate READ canTranslate NOTIFY pageUrlChanged)

public:
    explicit TranslationController(QObject* parent = nullptr);

    [[nodiscard]] auto targetLanguage() const -> QString;
    void setTargetLanguage(const QString& targetLanguage);

    [[nodiscard]] auto status() const -> QString;
    [[nodiscard]] auto pageUrl() const -> QUrl;
    [[nodiscard]] auto canTranslate() const -> bool;

    Q_INVOKABLE void openPage(const QUrl& pageUrl);
    Q_INVOKABLE void translatePage();

signals:
    void targetLanguageChanged();
    void statusChanged();
    void pageUrlChanged();

private:
    void setStatus(const QString& status);

    QString targetLanguage_{"Indonesian"};
    QString status_{"Import a manga page to begin."};
    QUrl pageUrl_;
};
