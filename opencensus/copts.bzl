# Copyright 2018, OpenCensus Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Compiler options for OpenCensus.

Flags specified here must not impact ABI. Code compiled with and without these
opts will be linked together, and in some cases headers compiled with and
without these options will be part of the same program.

We use the same flags as absl, plus turn some warnings into errors.
"""

load(
    "@com_google_absl//absl:copts.bzl",
    "GCC_FLAGS",
    "GCC_TEST_FLAGS",
    "LLVM_FLAGS",
    "LLVM_TEST_FLAGS",
    "MSVC_FLAGS",
    "MSVC_TEST_FLAGS",
)

WERROR = ["-Werror=return-type", "-Werror=switch"]

DEFAULT_COPTS = select({
    "//opencensus:llvm_compiler": LLVM_FLAGS + WERROR,
    "//opencensus:windows": MSVC_FLAGS,
    "//conditions:default": GCC_FLAGS + WERROR,
})

TEST_COPTS = DEFAULT_COPTS + select({
    "//opencensus:llvm_compiler": LLVM_TEST_FLAGS + WERROR,
    "//opencensus:windows": MSVC_TEST_FLAGS,
    "//conditions:default": GCC_TEST_FLAGS + WERROR,
})
