#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import Darwin.C
#else
import Glibc
#endif

public final class DateFormatter {
  /// WARNING: this uses `strftime` date format, not the Foundation date format.
  let dateFormat: String = "%Y-%m-%d %H:%M:%S"

  public init() {}

  public func string(from date: Date) -> String {
    let interval = date.timeIntervalSince1970
    // FIXME: not very sensible estimate, but should work short-term
    let bufferSize = dateFormat.count * 10
    var buffer = ContiguousArray<Int8>(repeating: 0, count: bufferSize)
    return buffer.withUnsafeMutableBufferPointer {
      guard
        let baseAddress = $0.baseAddress,
        dateFormat.withCString({ formatCString -> Int in
          var tt = tm(UTCSecondsSince1970: time_t(interval))
          return strftime(baseAddress, bufferSize, formatCString, &tt)
        }) > 0
      else { return "" }

      let milliseconds = Int(date.timeIntervalSince1970.truncatingRemainder(dividingBy: 1) * 1000)
      return String(cString: baseAddress).appendingFormat(".%03d", milliseconds)
    }
  }

  public func date(from string: String) -> Date? { nil }
}
