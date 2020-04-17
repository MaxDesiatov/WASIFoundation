//
//  DataTests.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 1/10/16.
//  Copyright © 2016 PureSwift.
//

#if canImport(Glibc)
import Glibc
#endif

@testable import WASIFoundation
import XCTest

final class DataTests: XCTestCase {
  func testFromBytePointer() {
    let string = "TestData"

    let testData = string.toUTF8Data()

    XCTAssert(testData.isEmpty == false, "Could not create test data")

    let dataPointer = UnsafeMutablePointer<UInt8>.allocate(capacity: testData.count)

    defer { dataPointer.deallocate() }

    memcpy(dataPointer, testData.bytes, testData.count)

    let data = WASIFoundation.Data(bytes: dataPointer, count: testData.count)

    XCTAssert(data == testData, "\(data) == \(testData)")
  }
}
