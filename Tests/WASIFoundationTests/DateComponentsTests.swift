//
//  DateComponentsTest.swift
//  SwiftFoundation
//
//  Created by David Ask on 07/12/15.
//  Copyright © 2015 PureSwift.
//

#if canImport(Glibc)
import Glibc
#endif

@testable import WASIFoundation
import XCTest

final class DateComponentsTest: XCTestCase {
  func testBuildDate() {
    var dateComponents = DateComponents()
    dateComponents.year = 1987
    dateComponents.month = 10
    dateComponents.dayOfMonth = 10

    let assertionDate = WASIFoundation.Date(timeIntervalSince1970: TimeInterval(560_822_400))
    let madeDate = dateComponents.date

    print(assertionDate, madeDate)

    XCTAssert(assertionDate == madeDate)
  }

  func testValueForComponent() {
    let dateComponents = DateComponents(timeIntervalSince1970: 560_822_400)

    XCTAssert(dateComponents[.year] == 1987)
    XCTAssert(dateComponents[.month] == 10)
    XCTAssert(dateComponents[.dayOfMonth] == 10)
  }
}
