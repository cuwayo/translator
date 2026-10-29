# translator

A modern C++23 command-line application scaffold for text translation.

The current command preserves its input unchanged. Replace the implementation in
`src/translator.cpp` with a translation provider or engine when the product
requirements are defined.

## Requirements

- CMake 3.25+
- A C++23-capable compiler
- GNU Make or another Make-compatible build tool

## Build and test

```sh
cmake --preset debug
cmake --build --preset debug
ctest --preset debug
```

Run the application:

```sh
./build/debug/translator "Hello, world!"
```

## GitHub

After creating an empty GitHub repository, publish the local repository:

```sh
git remote add origin git@github.com:YOUR_ACCOUNT/translator.git
git push -u origin main
```

GitHub Actions builds and tests each pull request and each push to `main`.
