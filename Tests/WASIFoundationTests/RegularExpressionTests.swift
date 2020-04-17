//
//  RegularExpressionTests.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 7/11/15.
//  Copyright © 2015 PureSwift.
//

#if canImport(Glibc)
import Glibc
#endif

import Foundation
@testable import WASIFoundation
import XCTest

final class RegularExpressionTests: XCTestCase {
  func testSimpleRegex() throws {
    let regex = try RegularExpression("Welcome")

    let string = "Welcome to RegExr v2.0 by gskinner.com!"

    guard let match = regex.match(string, options: [])
    else { XCTFail("Could not find match"); return }

    let stringRange = NSRange(match.range)

    let matchString = NSString(string: string).substring(with: stringRange)

    XCTAssert(matchString == "Welcome")
  }

  func testExtendedRegex() throws {
    let regex = try RegularExpression("a{3}", options: [.extendedSyntax])

    let string = "lorem ipsum aaa"

    guard let match = regex.match(string, options: [])
    else { XCTFail("Could not find match"); return }

    let stringRange = NSRange(match.range)

    let matchString = NSString(string: string).substring(with: stringRange)

    XCTAssert(matchString == "aaa")
  }

  func testWord() throws {
    // match 5 letter word
    let regex = try RegularExpression("[a-z, A-Z]{4}", options: [.extendedSyntax])

    let string = "Bird, Plane, Coleman"

    guard let match = regex.match(string, options: [])
    else { XCTFail("Could not find match"); return }

    let stringRange = NSRange(match.range)

    let matchString = NSString(string: string).substring(with: stringRange)

    XCTAssert(matchString == "Bird", matchString)
  }

  func testMultipleSubexpressions() throws {
    let string = "/abc/xyz"

    let regex = try RegularExpression("/([a-z]+)/([a-z]+)", options: [.extendedSyntax])

    guard let match = regex.match(string, options: [])
    else { XCTFail("Could not find match"); return }

    let stringRange = NSRange(match.range)

    let matchString = NSString(string: string).substring(with: stringRange)

    // matched whole string
    XCTAssert(matchString == string)

    // match subexpressions

    XCTAssert(
      match.subexpressionRanges.count == regex.subexpressionsCount)
  }

  func testEmoji() throws {
    let testString = "🙄😒🍺🦄"

    let beer = "🍺"

    let pattern = "\\(\(beer)\\)"

    let beerFinder = try RegularExpression(pattern)

    guard let match = beerFinder.match(testString) else {
      XCTFail("Could not find 🍺 in \(testString)")
      return
    }

    guard let beerRange = match.subexpressionRanges.first else {
      XCTFail("Could not find 🍺 capture group despite \(testString) match \(match)")
      return
    }

    guard let capturedString = testString.substring(range: beerRange) else {
      XCTFail("Failed to get a substring with range \(beerRange) in \(testString)")
      return
    }

    XCTAssertEqual(beer, capturedString)
  }
}
