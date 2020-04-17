//
//  POSIXTimeTests.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 7/22/15.
//  Copyright © 2015 PureSwift.
//

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import Darwin.C
#elseif canImport(Glibc)
import Glibc
#endif

@testable import WASIFoundation
import XCTest

final class POSIXTimeTests: XCTestCase {
  func testGetTimeOfDay() {
    var time = timeval()

    do { time = try timeval.timeOfDay() }

    catch {
      XCTFail("Error getting time: \(error)")
    }

    print("Current time: \(time)")
  }

  func testTimeVal() {
    let date = WASIFoundation.Date()

    let time = timeval(timeInterval: date.timeIntervalSince1970)

    XCTAssert(Int(time.timeInterval) == Int(date.timeIntervalSince1970))
  }

  func testTimeSpec() {
    let date = WASIFoundation.Date()

    let time = timespec(timeInterval: date.timeIntervalSince1970)

    XCTAssert(time.timeInterval == date.timeIntervalSince1970, "timespec: \(time.timeInterval) == Date: \(date)")
  }
}
