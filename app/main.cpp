#include <QGuiApplication>
#include <QQmlApplicationEngine>

auto main(int argc, char** argv) -> int {
    QGuiApplication application(argc, argv);
    QQmlApplicationEngine engine;
    engine.loadFromModule("Translator", "Main");

    if (engine.rootObjects().isEmpty()) {
        return 1;
    }

    return application.exec();
}
