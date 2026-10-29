#include <iostream>
#include <string_view>

#include "translator/translator.hpp"

namespace {

auto expect_equal(const std::string_view actual, const std::string_view expected,
                  const std::string_view description) -> bool {
    if (actual == expected) {
        return true;
    }

    std::cerr << "FAILED: " << description << "\n"
              << "Expected: " << expected << "\n"
              << "Actual:   " << actual << '\n';
    return false;
}

}  // namespace

auto main() -> int {
    const bool keeps_input = expect_equal(translator::translate("Hello, world!"), "Hello, world!",
                                          "the bootstrap translator preserves input");

    return keeps_input ? 0 : 1;
}
