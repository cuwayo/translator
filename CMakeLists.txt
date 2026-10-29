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

add_executable(translator app/main.cpp)
target_link_libraries(translator PRIVATE translator::lib)

include(GNUInstallDirs)
install(TARGETS translator translator_lib)
install(DIRECTORY include/ DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}")

include(CTest)
if(BUILD_TESTING AND TRANSLATOR_BUILD_TESTS)
  add_executable(translator_tests tests/translator_tests.cpp)
  target_link_libraries(translator_tests PRIVATE translator::lib)
  add_test(NAME translator_tests COMMAND translator_tests)
endif()
