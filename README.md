# WASIFoundation

[![Swift](https://img.shields.io/badge/swift-5.1-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![License](https://img.shields.io/badge/license-MIT-71787A.svg)](https://tldrlegal.com/license/mit-license)

Minimalistic Swift Foundation built on top of [the WebAssembly System Interface](https://wasi.dev/). Only a very limited subset of the API is implemented, just enough to bootstrap [the SwiftWasm efforts](https://swiftwasm.org), namely

* `Data` (base64 API not supported yet)
* `FileHandle.init(fileDescriptor:)`, `FileHandle.write(_:)`, `FileHandle.standardError`
* `JSONDecoder` and `JSONEncoder`
* `RegularExpression`
* Basic `DateComponents` API
* `Date`
* `DateFormatter` with a hardcoded ISO format, custom formatting with the Foundation format isn't supported yet (because `strftime` format [is substantially different](https://www.tutorialspoint.com/c_standard_library/c_function_strftime.htm) from Foundation's format specifiers)
* `String.init(format:arguments:)`, `String.appendingFormat`, `String.appending`
* Basic `URL` API.

## Contributing

This project adheres to the [Contributor Covenant Code of
Conduct](/CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## License

This project uses parts of [SwiftFoundation](https://github.com/PureSwift/SwiftFoundation), which
are distributed under the terms of [the MIT License](/SwiftFoundation-LICENSE).

The rest of the code is distributed under the [Apache 2.0 license](/LICENSE).
