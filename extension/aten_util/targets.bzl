load("@fbsource//xplat/executorch/build:runtime_wrapper.bzl", "runtime")

def define_common_targets():
    """Defines targets that should be shared between fbcode and xplat.

    The directory containing this targets.bzl file should also contain both
    TARGETS and BUCK files that call this function.
    """

    runtime.cxx_library(
        name = "aten_bridge",
        srcs = ["aten_bridge.cpp"],
        exported_headers = ["aten_bridge.h"],
        compiler_flags = [
            "-frtti",
            "-fno-omit-frame-pointer",
            "-fexceptions",
            "-Wno-error",
            "-Wno-unused-local-typedef",
            "-Wno-self-assign-overloaded",
            "-Wno-global-constructors",
            "-Wno-unused-function",
        ],
        visibility = [
            "//executorch/...",
            "@EXECUTORCH_CLIENTS",
        ],
        deps = [
            "//executorch/runtime/core:core",
            "//executorch/runtime/core/exec_aten:lib",
        ],
        external_deps = [
            "torch-core-cpp",
        ],
    )
