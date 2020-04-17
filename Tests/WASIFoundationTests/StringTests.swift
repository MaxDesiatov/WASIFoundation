//
//  StringTests.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 9/23/15.
//  Copyright © 2015 PureSwift.
//

#if canImport(Glibc)
import Glibc
#endif

@testable import WASIFoundation
import XCTest

final class StringTests: XCTestCase {
  // MARK: - Functional Tests

  func testUTF8Data() {
    let string = "Test Text 😃"

    let data = string.toUTF8Data()

    let decodedString = String(UTF8Data: data)!

    XCTAssert(string == decodedString, "\(string) == \(decodedString)")
  }
}
