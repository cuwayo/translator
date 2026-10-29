cmake_minimum_required(VERSION 3.25)

project(
    translator
    VERSION 0.1.0
    DESCRIPTION "A modern C++ translation application"
    LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(TRANSLATOR_BUILD_TESTS "Build translator tests" ON)
option(TRANSLATOR_BUILD_UI "Build the Qt Quick desktop application" ON)

if(TRANSLATOR_BUILD_UI)
    find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)
    qt_standard_project_setup(REQUIRES 6.5)
    if(Qt6_VERSION VERSION_GREATER_EQUAL 6.8)
        qt_policy(SET QTP0004 NEW)
    endif()
else()
    include(GNUInstallDirs)
endif()

add_library(translator_lib
    src/translator.cpp
)
add_library(translator::lib ALIAS translator_lib)

target_include_directories(translator_lib
    PUBLIC
        "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
        "$<INSTALL_INTERFACE:include>"
)
target_compile_features(translator_lib PUBLIC cxx_std_23)

if(MSVC)
    target_compile_options(translator_lib PRIVATE /W4 /permissive-)
else()
    target_compile_options(translator_lib PRIVATE -Wall -Wextra -Wpedantic -Wconversion -Wsign-conversion)
endif()

install(TARGETS translator_lib
    LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
)
install(DIRECTORY include/ DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}")

if(TRANSLATOR_BUILD_UI)
    qt_add_executable(translator
        app/main.cpp
    )

    qt_add_qml_module(translator
        URI Translator
        VERSION 1.0
        QML_FILES
            qml/Main.qml
        SOURCES
            include/translator/translation_controller.hpp
            src/translation_controller.cpp
    )

    target_link_libraries(translator
        PRIVATE
            translator::lib
            Qt6::Quick
    )

    set_target_properties(translator PROPERTIES
        MACOSX_BUNDLE TRUE
        WIN32_EXECUTABLE TRUE
    )

    install(TARGETS translator
        RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
        BUNDLE DESTINATION "."
    )
endif()

include(CTest)
if(BUILD_TESTING AND TRANSLATOR_BUILD_TESTS)
    add_executable(translator_tests tests/translator_tests.cpp)
    target_link_libraries(translator_tests PRIVATE translator::lib)
    add_test(NAME translator_tests COMMAND translator_tests)
endif()
