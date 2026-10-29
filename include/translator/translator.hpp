#pragma once

#include <string>
#include <string_view>

namespace translator {

/// Returns the input unchanged until a translation provider is configured.
[[nodiscard]] auto translate(std::string_view text) -> std::string;

}  // namespace translator
