#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import Darwin.C
#else
import Glibc
#endif

private let libcWrite = write

public final class FileHandle {
  public let fileDescriptor: Int32

  public init(fileDescriptor: Int32) {
    self.fileDescriptor = fileDescriptor
  }

  static var standardError: FileHandle {
    .init(fileDescriptor: STDERR_FILENO)
  }

  func write(_ data: Data) {
    _ = data._bytes.withUnsafeBytes {
      libcWrite(fileDescriptor, $0.baseAddress, data.count)
    }
  }
}
