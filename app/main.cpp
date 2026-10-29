#include <iostream>
#include <string>
#include <string_view>

#include "translator/translator.hpp"

namespace {

auto join_arguments(const int count, char* const* arguments) -> std::string {
    std::string result;

    for (int index = 1; index < count; ++index) {
        if (!result.empty()) {
            result += ' ';
        }
        result += arguments[index];
    }

    return result;
}

}  // namespace

auto main(const int argc, char** argv) -> int {
    const std::string input = join_arguments(argc, argv);

    if (input.empty()) {
        std::cerr << "Usage: translator <text>\n";
        return 1;
    }

    std::cout << translator::translate(std::string_view{input}) << '\n';
    return 0;
}
