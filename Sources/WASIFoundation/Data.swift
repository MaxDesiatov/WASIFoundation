//
//  Data.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 6/28/15.
//  Copyright © 2015 PureSwift.
//

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import Darwin.C
#else
import Glibc
#endif

/// Encapsulates data.
public struct Data: Equatable, Hashable, CustomStringConvertible, RandomAccessCollection, MutableCollection {
  public typealias Index = Int
  public typealias Indices = DefaultIndices<Data>

  // MARK: - Properties

  internal var _bytes: ContiguousArray<UInt8>

  // MARK: - Initialization

  /// Initialize a `Data` with the contents of a Sequence.
  ///
  /// - parameter bytes: An array of bytes to copy.
  public init<S>(_ elements: S) where S: Sequence, S.Element == UInt8 {
    _bytes = ContiguousArray(elements)
  }

  public init() {
    _bytes = ContiguousArray()
  }

  public init(bytes: ArraySlice<UInt8>) {
    _bytes = ContiguousArray(bytes)
  }

  /// Initialize a `Data` with the specified size.
  ///
  /// - parameter capacity: The size of the data.
  public init(count: Int) {
    _bytes = ContiguousArray(repeating: 0, count: count)
  }

  /// Initialize a `Data` with copied memory content.
  ///
  /// - parameter bytes: A pointer to the memory. It will be copied.
  /// - parameter count: The number of bytes to copy.
  public init(bytes pointer: UnsafeRawPointer, count: Int) {
    _bytes = ContiguousArray<UInt8>(repeating: 0, count: count)

    memcpy(&_bytes, pointer, count)
  }

  /// Initialize a `Data` with copied memory content.
  ///
  /// - parameter buffer: A buffer pointer to copy. The size is calculated from `SourceType` and `buffer.count`.
  public init<SourceType>(buffer: UnsafeBufferPointer<SourceType>) {
    guard let pointer = buffer.baseAddress
    else { self.init(); return }

    self.init(bytes: pointer, count: MemoryLayout<SourceType>.size * buffer.count)
  }

  // MARK: - Accessors

  public func hash(into hasher: inout Hasher) {
    hasher.combine(count)

    _bytes.withUnsafeBytes {
      // We have access to the full byte buffer here, but not all of it is meaningfully used (bytes
      // past self.length may be garbage).
      let bytes = UnsafeRawBufferPointer(start: $0.baseAddress, count: self.count)
      hasher.combine(bytes: bytes)
    }
  }

  public var description: String {
    "<" + _bytes.map { $0.toHexadecimal() }.joined() + ">"
  }

  // MARK: - Methods

  /// Append data to the data.
  ///
  /// - parameter data: The data to append to this data.
  public mutating func append(_ other: Data) {
    _bytes += other._bytes
  }

  /// Return a new copy of the data in a specified range.
  ///
  /// - parameter range: The range to copy.
  public func subdata(in range: Range<Index>) -> Data {
    Data(bytes: _bytes[range])
  }

  // MARK: - Index and Subscript

  /// Sets or returns the byte at the specified index.

  public subscript(index: Index) -> UInt8 {
    get { _bytes[index] }

    set { _bytes[index] = newValue }
  }

  public subscript(bounds: Range<Int>) -> Slice<Data> {
    get { Slice(base: self, bounds: bounds) }
    set { _bytes.replaceSubrange(bounds, with: newValue) }
  }

  public var count: Int {
    _bytes.count
  }

  /// The start `Index` in the data.
  public var startIndex: Index {
    0
  }

  /// The end `Index` into the data.
  ///
  /// This is the "one-past-the-end" position, and will always be equal to the `count`.
  public var endIndex: Index {
    count
  }

  public func index(before i: Index) -> Index {
    i - 1
  }

  public func index(after i: Index) -> Index {
    i + 1
  }
}

// MARK: - Equatable

public func ==(lhs: Data, rhs: Data) -> Bool {
  guard lhs.count == rhs.count else { return false }

  var bytes1 = lhs._bytes

  var bytes2 = rhs._bytes

  return memcmp(&bytes1, &bytes2, lhs._bytes.count) == 0
}

// MARK: - Operators

public func +(lhs: Data, rhs: Data) -> Data {
  var result = Data()

  result._bytes = lhs._bytes + rhs._bytes

  return result
}

public extension String {
  #if os(WASI)
  enum Encoding {
    case utf8
  }
  #endif

  func data(using encoding: Encoding) -> Data? {
    guard encoding == .utf8 else { return nil }

    return Data(utf8)
  }

  init?(data: Data, encoding: Encoding) {
    guard let string = data._bytes.withUnsafeBytes({ pointer -> String? in
      guard
        let baseAddress = pointer.bindMemory(to: CChar.self).baseAddress
      else { return nil }

      return String(validatingUTF8: baseAddress)
    }) else { return nil }

    self = string
  }

  init?<S>(bytes: S, encoding: String.Encoding) where S: Sequence, S.Element == UInt8 {
    self.init(data: Data(bytes), encoding: encoding)
  }
}
