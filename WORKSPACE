workspace(name = "bazel_ndn")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "bazel_skylib",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.2.1/bazel-skylib-1.2.1.tar.gz",
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.2.1/bazel-skylib-1.2.1.tar.gz",
    ],
    sha256 = "f7be3474d42aae265405a592bb7da8e171919d74c16f082a5457840f06054728",
)

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")
bazel_skylib_workspace()

http_archive(
    name = "rules_python",
    sha256 = "cdf6b84084aad8f10bf20b46b77cb48d83c319ebe6458a18e9d2cebf57807cdd",
    strip_prefix = "rules_python-0.8.1",
    url = "https://github.com/bazelbuild/rules_python/archive/refs/tags/0.8.1.tar.gz",
)

# we need tools from bazel, or write our own parser, but it seems easier to fetch tools
# TODO: actually just copy source from bazel and compile under rules
# this should be quite compatible with upstream and will not require to fetch entire bazel
http_archive(
    name = "io_bazel",
    sha256 = "a394a99cae2d28179e1afca5f5e867fe36143478b81ccb5713d003dd827cc0fe",
    strip_prefix = "bazel-5.1.0",
    urls = [
        "https://github.com/bazelbuild/bazel/archive/5.1.0.zip",
    ],
)

# io_bazel dep
http_archive(
    name = "com_google_protobuf",
    sha256 = "bf0e5070b4b99240183b29df78155eee335885e53a8af8683964579c214ad301",
    strip_prefix = "protobuf-3.14.0",
    type = "zip",
    urls = [
        "https://github.com/protocolbuffers/protobuf/archive/v3.14.0.zip",
    ],
)

load(
    "@com_google_protobuf//:protobuf_deps.bzl",
    "protobuf_deps",
)

protobuf_deps()