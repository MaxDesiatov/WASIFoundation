#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import Darwin.C
#else
import Glibc
#endif

public final class DateFormatter {
  /// WARNING: this uses `strftime` date format, not the Foundation date format.
  public var dateFormat: String = "%Y-%m-%d %H:%M:%S"

  public init() {}

  public func string(from date: Date) -> String {
    // FIXME: not very sensible estimate, but should work short-term
    let bufferSize = dateFormat.count * 10
    var buffer = ContiguousArray<Int8>(repeating: 0, count: bufferSize)
    return buffer.withContiguousMutableStorageIfAvailable { mutableBuffer in
      guard
        let baseAddress = mutableBuffer.baseAddress,
        dateFormat.withCString({ (formatCString) -> Int in
          var tt = tm(UTCSecondsSince1970: time_t(date.timeIntervalSince1970))
          return strftime(baseAddress, bufferSize, formatCString, &tt)
        }) > 0
      else { return "" }

      return String(cString: baseAddress)
    } ?? ""
  }

  public func date(from string: String) -> Date? { nil }
}
