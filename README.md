# Translator

A modern C++23 desktop application for text translation, built with Qt Quick.

The interface supports selecting languages and entering source text. The current
translation backend deliberately preserves source text until a translation provider
is selected and configured.

## Requirements

- CMake 3.25+
- A C++23-capable compiler
- Qt 6.5+ with the Quick and QML development modules
- GNU Make or another Make-compatible build tool

## Build and test

```sh
cmake --preset debug
cmake --build --preset debug
ctest --preset debug
```

To build only the framework-independent C++ core and its tests on a machine
without Qt installed:

```sh
cmake -S . -B build/core -DTRANSLATOR_BUILD_UI=OFF
cmake --build build/core
ctest --test-dir build/core
```

Run the application:

```sh
./build/debug/translator
```

## Architecture

- `src/translator.cpp` — framework-independent translation engine seam.
- `src/translation_controller.cpp` — C++ state and actions exposed to QML.
- `qml/Main.qml` — the desktop interface.

Translation logic stays in C++; QML is responsible only for presentation and
interaction. The controller is registered as a QML type using Qt's modern CMake
integration.

## License

This project's code is licensed under the [GNU General Public License,
version 3](LICENSE) (GPL-3.0-only). Qt's GPLv3 option is compatible with this
license.

## GitHub

After creating an empty GitHub repository, publish the local repository:

```sh
git remote add origin git@github.com:YOUR_ACCOUNT/translator.git
git push -u origin main
```

GitHub Actions builds and tests each pull request and each push to `main`.
