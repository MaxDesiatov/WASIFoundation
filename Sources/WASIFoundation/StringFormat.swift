#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import Darwin
#else
import Glibc
#endif

public extension String {
  init<T: StringProtocol>(format: T, arguments: [CVarArg]) {
    // FIXME: not very sensible estimate, but should work short-term
    let bufferSize = format.count * 3
    var buffer = ContiguousArray<Int8>(repeating: 0, count: bufferSize)

    self = buffer.withUnsafeMutableBufferPointer {
      guard
        let baseAddress = $0.baseAddress,
        format.withCString({ formatPointer in
          withVaList(arguments) {
            vsnprintf(baseAddress, bufferSize, formatPointer, $0)
          }
        }) > 0
      else { return "" }

      return String(cString: baseAddress)
    }
  }
}

public extension StringProtocol {
  func appendingFormat<T: StringProtocol>(_ format: T, _ args: CVarArg...) -> String {
    appending(String(format: format, arguments: args))
  }

  func appending<T: StringProtocol>(_ string: T) -> String {
    var result = String(self)
    result.append(contentsOf: string)

    return result
  }
}
