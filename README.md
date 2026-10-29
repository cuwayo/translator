# Manga Translator

A modern C++23 desktop application for translating manga pages, built with Qt
Quick.

The application workflow is: import an image, detect text and speech bubbles,
translate the detected text, review it in context, then export a translated page.
The current implementation includes the image-import UI and provider boundary;
OCR, translation, and image-rendering providers still need to be chosen.

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
- `src/translation_controller.cpp` — C++ page-import state and pipeline actions
  exposed to QML.
- `qml/Main.qml` — image import, preview, language selection, and workflow UI.

Translation logic stays in C++; QML is responsible only for presentation and
interaction. OCR, bubble detection, machine translation, and image rendering
will be separate provider implementations behind the C++ pipeline.

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
