import Foundation
import FMake

OutputLevel.default = .error

print("building openssl - static")

try sh(#"./build-libssl.sh --targets="$OPENSSL_TARGETS" --disable-bitcode"#)

try sh("./create-openssl-framework.sh static")

try cd("xcframeworks/static") {
    try sh("zip --symlinks -r ../../openssl-static.xcframework.zip openssl.xcframework")
}

print("building openssl - dynamic")

try sh("zip --symlinks -r openssl-libs.zip libs")

try sh("./create-openssl-framework.sh dynamic")

try cd("xcframeworks/dynamic") {
    try sh("zip -r ../../openssl-dynamic.xcframework.zip openssl.xcframework")
}

try cd("frameworks/static") {
    try sh("zip --symlinks -r ../../openssl-static.frameworks.zip .")
}

try cd("frameworks/dynamic") {
    try sh("zip --symlinks -r ../../openssl-dynamic.frameworks.zip .")
}

let releaseMD =
  """
    ### XCFrameworks
    | File                            | SHA 256                                             |
    | ------------------------------- |:---------------------------------------------------:|
    | openssl-static.xcframework.zip  | \(try sha(path: "openssl-static.xcframework.zip"))  |
    | openssl-dynamic.xcframework.zip | \(try sha(path: "openssl-dynamic.xcframework.zip")) |

    ### Frameworks
    | File                            | SHA 256                                             |
    | ------------------------------- |:---------------------------------------------------:|
    | openssl-static.frameworks.zip   | \(try sha(path: "openssl-static.frameworks.zip"))   |
    | openssl-dynamic.frameworks.zip  | \(try sha(path: "openssl-dynamic.frameworks.zip"))  |
  """

try write(content: releaseMD, atPath: "release.md")
