#pragma once

#include <QtQml/qqmlregistration.h>

#include <QObject>
#include <QString>

class TranslationController final : public QObject {
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(QString inputText READ inputText WRITE setInputText NOTIFY inputTextChanged)
    Q_PROPERTY(QString translatedText READ translatedText NOTIFY translatedTextChanged)
    Q_PROPERTY(QString sourceLanguage READ sourceLanguage WRITE setSourceLanguage NOTIFY
                   sourceLanguageChanged)
    Q_PROPERTY(QString targetLanguage READ targetLanguage WRITE setTargetLanguage NOTIFY
                   targetLanguageChanged)
    Q_PROPERTY(QString status READ status NOTIFY statusChanged)

   public:
    explicit TranslationController(QObject* parent = nullptr);

    [[nodiscard]] auto inputText() const -> QString;
    void setInputText(const QString& inputText);

    [[nodiscard]] auto translatedText() const -> QString;

    [[nodiscard]] auto sourceLanguage() const -> QString;
    void setSourceLanguage(const QString& sourceLanguage);

    [[nodiscard]] auto targetLanguage() const -> QString;
    void setTargetLanguage(const QString& targetLanguage);

    [[nodiscard]] auto status() const -> QString;

    Q_INVOKABLE void translate();

   signals:
    void inputTextChanged();
    void translatedTextChanged();
    void sourceLanguageChanged();
    void targetLanguageChanged();
    void statusChanged();

   private:
    void setTranslatedText(const QString& translatedText);
    void setStatus(const QString& status);

    QString inputText_;
    QString translatedText_;
    QString sourceLanguage_{"English"};
    QString targetLanguage_{"Indonesian"};
    QString status_{"Ready"};
};
